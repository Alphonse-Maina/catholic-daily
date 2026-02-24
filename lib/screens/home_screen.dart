import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/liturgical_service.dart';
import '../models/liturgical_day.dart';
import '../services/readings_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String>? readings;
  LiturgicalDay? today;
  String saint = "Loading...";
  late ReadingsService rservice;

  @override
  void initState() {
    super.initState();
    rservice = ReadingsService();
    loadData();
  }

  Future<void> loadData() async {
    final lservice = LiturgicalService();
    final now = DateTime.now();
    final lit = lservice.getDay(now);

    final jsonString = await rootBundle.loadString('lib/data/saints.json');
    final List saints = json.decode(jsonString);

    final found = saints.firstWhere(
          (s) =>
      s["month_num"] == now.month.toString() &&
          s["saint_day"] == now.day.toString(),
      orElse: () => null,
    );
    readings = rservice.getTodayReadings();

    if (readings == null) {
      // If nothing stored, sync first
      await rservice.syncNext30Days();
      readings = rservice.getTodayReadings();
    }
    
    setState(() {
      today = lit;
      saint = found?["saint_name"] ?? "No saint today";

    });
  }


  @override
  Widget build(BuildContext context) {
    if (today == null) {
      return const Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 40,),
            Text("Please hold as we load Readings.")
          ],
        )),
      );
    }

    final Color bgColor = today!.colorValue;

    return Scaffold(
      backgroundColor: bgColor.withOpacity(.12),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        title: const Text("Catholic Daily"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.church, color: bgColor, size: 24),
                      const SizedBox(width: 8),
                      const Text(
                        "Today’s Liturgy",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // SEASON
                  _liturgyTile(
                    icon: Icons.auto_awesome,
                    label: "Season",
                    value: today!.season,
                    bgColor: bgColor,
                  ),

                  const SizedBox(height: 14),

                  // COLOR
                  _liturgyTile(
                    icon: Icons.palette,
                    label: "Liturgical Color",
                    value: today!.color,
                    bgColor: bgColor,
                  ),

                  const SizedBox(height: 14),

                  // CELEBRATION
                  _liturgyTile(
                    icon: Icons.celebration,
                    label: "Celebration",
                    value: today!.celebration,
                    bgColor: bgColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _card(
              bgColor,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title("Saint of the Day"),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: bgColor.withOpacity(.2),
                          child: Icon(Icons.person, size: 28, color: bgColor),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            saint,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
            ),
            const SizedBox(height: 4),
            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SectionTitle("Daily Verse"),
                  SizedBox(height: 8),
                  Text(
                    "For God so loved the world, that He gave His only son, that whoever believes in Him may not perish, but have eternal Salvation.",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle("Mass Readings"),
                  const SizedBox(height: 8),
                  if (readings == null)
                    const Center(child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text("Please wait while we load Readings ..."),
                        SizedBox(height: 10,),
                        Text("Ensure you are connected to the internet")
                      ],
                    ))
                  else if (readings!.isEmpty)
                    const Text("Unable to load readings")
                  else
                    ...readings!.entries.map(
                          (e) => Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: bgColor.withOpacity(.25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: bgColor,
                                letterSpacing: .5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              height: 2,
                              width: 40,
                              color: bgColor.withOpacity(.5),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              e.value,
                              style: const TextStyle(
                                fontSize: 17,
                                height: 1.6,
                                letterSpacing: .2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(Color color, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$title: ",
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
              child: Text(value, style: const TextStyle(fontSize: 16)))
        ],
      ),
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
Widget _liturgyTile({
  required IconData icon,
  required String label,
  required String value,
  required Color bgColor,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: bgColor.withOpacity(.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: bgColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  letterSpacing: .5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

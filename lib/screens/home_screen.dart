import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/liturgical_service.dart';
import '../models/liturgical_day.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LiturgicalDay? today;
  String saint = "Loading...";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final service = LiturgicalService();
    final now = DateTime.now();

    final lit = service.getDay(now);

    final jsonString = await rootBundle.loadString('lib/data/saints.json');
    final List saints = json.decode(jsonString);

    final found = saints.firstWhere(
          (s) =>
      s["month_num"] == now.month.toString() &&
          s["saint_day"] == now.day.toString(),
      orElse: () => null,
    );

    setState(() {
      today = lit;
      saint = found?["saint_name"] ?? "No saint today";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (today == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
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
                  _title("Today’s Liturgy"),
                  const SizedBox(height: 10),
                  _row("Season", today!.season),
                  _row("Color", today!.color),
                  _row("Celebration", today!.celebration),
                ],
              ),
            ),

            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Saint of the Day"),
                  const SizedBox(height: 8),
                  Text(
                    saint,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),

            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SectionTitle("Daily Verse"),
                  SizedBox(height: 8),
                  Text(
                    "Verse will appear here",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),

            _card(
              bgColor,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SectionTitle("Mass Readings"),
                  SizedBox(height: 8),
                  Text(
                    "Readings will load here",
                    style: TextStyle(fontSize: 17),
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

import 'package:catholic_daily/screens/pray_with_me.dart';
import 'package:flutter/material.dart';
import '../data/rosary_loader.dart';
import '../models/liturgical_day.dart';
import '../models/mystery.dart';
import '../services/liturgical_service.dart';
import 'list_mysteries_screen.dart';

class RosaryScreen extends StatefulWidget {
  const RosaryScreen({super.key});

  @override
  State<RosaryScreen> createState() => _RosaryScreenState();
}

class _RosaryScreenState extends State<RosaryScreen> {
  LiturgicalDay? today;
  Color themeColor = Colors.blue;
  Map <String, List<Mystery>> allMysteries = {};

  @override
  void initState() {
    super.initState();
    _loadMysteries();
  }

  Future<void> _loadMysteries() async {
    final mysteriesMap = await RosaryLoader.loadAllMysteries();
    final service = LiturgicalService();
    final now = DateTime.now();

    final lit = service.getDay(now);

    setState(() {
      allMysteries = mysteriesMap;
      themeColor = lit!.colorValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.withOpacity(.12),
      appBar: AppBar(
        title: Text("The Mysteries of the Rosary"),
        backgroundColor: themeColor,
        centerTitle: true,
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: allMysteries.keys.map((key) {
              return ListTile(
                title: Text("The ${key[0].toUpperCase()}${key.substring(1)} Mysteries"),
                subtitle: Text("Has ${allMysteries[key]!.length} mysteries"),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ListMysteriesScreen(
                            title: key.toString(),
                            allMysteries: allMysteries[key]!,
                            color: themeColor,
                          )
                      ),
                  );
              }
              );
            }).toList(),
          ),
        ),
        SizedBox( height: 20,),
        ElevatedButton(
            onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (_)=> PrayWithMe()),
              );
            },
            child: Text("Pray Today's Rosary")
        )
      ],
    ),

    );
  }
}

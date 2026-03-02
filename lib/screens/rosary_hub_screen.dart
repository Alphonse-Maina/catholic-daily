import 'package:catholic_daily/constants/colors.dart';
import 'package:catholic_daily/screens/divine_mercy_screen.dart';
import 'package:catholic_daily/screens/holy_spirit_chaplet_screen.dart';
import 'package:catholic_daily/screens/holy_wounds_chaplet.dart';
import 'package:catholic_daily/screens/precious_blood_chaplet_screen.dart';
import 'package:catholic_daily/screens/rosary_screen.dart';
import 'package:catholic_daily/screens/seven_sorrows_screen.dart';
import 'package:catholic_daily/screens/st_joseph_chaplet_screen.dart';
import 'package:catholic_daily/screens/st_michael_chaplet_screen.dart';
import 'package:catholic_daily/screens/way_of_the_cross_screen.dart';
import 'package:flutter/material.dart';
import 'litany_screen.dart';

class RosaryHubScreen extends StatefulWidget {
  const RosaryHubScreen({super.key});


  @override
  State<RosaryHubScreen> createState() => _RosaryHubScreenState();
}

class _RosaryHubScreenState extends State<RosaryHubScreen> {
  Color themeColor = AppColors.appBarBackground;

  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Rosary & Chaplets"),
        centerTitle: true,
        backgroundColor: themeColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Rosary & Devotions
          const SectionTitle(title: "Rosary & Devotions"),
          PrayerTile(
            title: "Holy Rosary/ Marian Rosaries",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RosaryScreen()),
              );
            },
          ),
          PrayerTile(
            title: "Divine Mercy",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DivineMercyScreen()),
              );
            },
          ),
          PrayerTile(
            title: "Seven Sorrows",
            onTap: () {
              Navigator.push(
                  context,
              MaterialPageRoute(builder: (_) => const SevenSorrowsScreen()),
              );
            },
          ),
          PrayerTile(
            title: "Way of the Cross",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WayOfTheCrossScreen()),
              );
            },
          ),

          // Chaplets
          const SectionTitle(title: "Chaplets"),
          PrayerTile(title: "St. Michael", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StMichaelChapletScreen()),
            );
          }),
          PrayerTile(title: "Precious Blood", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PreciousBloodChapletPage()),
            );
          }),
          PrayerTile(title: "Holy Spirit", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HolySpiritChapletPage()),
            );
          }),
          PrayerTile(title: "Holy Wounds", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HolyWoundsChapletPage()),
            );
          }),
          PrayerTile(title: "St. Joseph", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StJosephChapletScreen()),
            );
          }),

          // Litanies
          const SectionTitle(title: "Litanies"),
          PrayerTile(title: "Litany of our lady", onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LitanyScreen(
                assetPath: 'lib/data/litany_of_our_lady.json',
              ),
            ),
            );}
          ),
          PrayerTile(title: "Litany of Seven Sorrows", onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LitanyScreen(
                assetPath: 'lib/data/litany_of_seven_sorrows.json',
              ),
            ),
          );}
          ),
          PrayerTile(title: "Litany of St. Joseph", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LitanyScreen(
                  assetPath: 'lib/data/litany_of_st_joseph.json',
                ),
              ),
            );
          }),
          PrayerTile(title: "Litany of St. Michael", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LitanyScreen(
                  assetPath: 'lib/data/litany_of_st_michael.json',
                ),
              ),
            );
          }),
        ],
      ),
    );
  }


}
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class PrayerTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PrayerTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
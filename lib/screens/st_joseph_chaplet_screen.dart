import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StJosephChapletScreen extends StatelessWidget {
  const StJosephChapletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Chaplet of St. Joseph"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Center(
              child: Text(
                "The St. Joseph Chaplet",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 16),

            PrayerText(
                "The Saint Joseph Chaplet is divided into fifteen groups of four beads "
                    "consisting of one single bead and a group of three beads. "
                    "The single bead symbolizes St. Joseph’s purity, and the group of three beads "
                    "his saintly piety. A mystery of the Rosary is considered on each single bead, "
                    "and two Hail Mary’s are said."
            ),

            SizedBox(height: 24),

            SectionTitle("Opening Prayer"),
            PrayerText(
                "Make the Sign of the Cross.\n\n"
                    "St. Joseph, foster-father of the Word Incarnate, "
                    "intercede for me that I might understand these mysteries."
            ),

            SizedBox(height: 24),

            MysterySection("The Annunciation"),
            MysterySection("The Visitation"),
            MysterySection("The Nativity"),
            MysterySection("The Presentation in the Temple"),
            MysterySection("The Finding of Our Lord in the Temple"),

            MysterySection("The Agony in the Garden"),
            MysterySection("The Scourging at the Pillar"),
            MysterySection("The Crowning with Thorns"),
            MysterySection("The Carrying of the Cross"),
            MysterySection("The Crucifixion"),

            MysterySection("The Resurrection"),
            MysterySection("The Ascension"),
            MysterySection("The Descent of the Holy Spirit"),
            MysterySection("The Assumption of Mary"),
            MysterySection("The Coronation of the Blessed Virgin"),

            SizedBox(height: 24),

            SectionTitle("Closing Prayers"),
            PrayerText(
                "V. Pray for us, O holy St. Joseph!\n"
                    "R. That we may be made worthy of the promises of Christ!\n\n"
                    "Let us pray:\n\n"
                    "O God, Who has predestined St. Joseph from all eternity "
                    "for the service of Thine Eternal Son and His Blessed Mother, "
                    "and made him worthy to be the spouse of this Blessed Virgin "
                    "and the foster father of Thy Son; we beseech Thee, "
                    "through all the services he has rendered to Jesus and Mary on earth, "
                    "that Thou wouldst make us worthy of his intercession "
                    "and grant us to enjoy the happiness of his company in heaven. "
                    "Through Christ our Lord. Amen."
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
class MysterySection extends StatelessWidget {
  final String title;
  const MysterySection(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title),

          const PrayerText(
              "On Single Bead:\n"
                  "Praised and blessed be Jesus, Mary and Joseph!\n\n"
                  "Say 2 Hail Marys (add your petition)\n\n"
                  "On Each of the 3 Beads:\n"
                  "Praised and blessed be Jesus, Mary and Joseph!"
          ),
        ],
      ),
    );
  }
}
class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.brown,
        ),
      ),
    );
  }
}

class PrayerText extends StatelessWidget {
  final String text;
  const PrayerText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        height: 1.6,
      ),
    );
  }
}
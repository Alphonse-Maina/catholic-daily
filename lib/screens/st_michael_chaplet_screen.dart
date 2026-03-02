import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StMichaelChapletScreen extends StatelessWidget {
  const StMichaelChapletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("St. Michael Chaplet"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            // Title
            Center(
              child: Text(
                "Chaplet of St. Michael\n(Rosary of the Angels)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 24),

            SectionTitle("Opening Act of Contrition"),
            PrayerText(
                "V/. O God, come to my assistance\n"
                    "R/. O Lord, make haste to help me.\n\n"
                    "Glory be..."
            ),

            SizedBox(height: 24),

            SectionTitle("First Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Seraphim, "
                    "may the Lord make us worthy to burn with the fire of perfect charity. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Second Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Cherubim, "
                    "may the Lord grant us grace to leave the ways of wickedness and run in the paths of Christian perfection. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Third Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Thrones, "
                    "may the Lord infuse into our hearts a true and sincere spirit of humility. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Fourth Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Dominations, "
                    "may the Lord give us grace to govern our senses and subdue our unruly passions. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Fifth Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Virtues, "
                    "may the Lord preserve us from evil and suffer us not to fall into temptation. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Sixth Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Powers, "
                    "may the Lord protect our souls against the snares and temptations of the devil. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Seventh Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Principalities, "
                    "may God fill our souls with a true spirit of obedience. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Eighth Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Archangels, "
                    "may the Lord give us perseverance in faith and in all good works, "
                    "so that we may gain the glory of Paradise. Amen.\n\n"
                    "Our Father (3x) – Hail Mary"
            ),

            SizedBox(height: 20),

            SectionTitle("Ninth Salutation"),
            PrayerText(
                "By the intercession of St. Michael and the celestial Choir of Angels, "
                    "may the Lord grant us to be protected by them in this mortal life "
                    "and conducted to eternal glory. Amen.\n\n"
                    "Our Father (3x) – Hail Mary\n\n"
                    "In honour of St. Michael – Our Father\n"
                    "In honour of St. Gabriel – Our Father\n"
                    "In honour of St. Raphael – Our Father\n"
                    "In honour of our Guardian Angel – Our Father"
            ),

            SizedBox(height: 24),

            SectionTitle("Concluding Prayer"),
            PrayerText(
                "O Glorious Prince St. Michael, chief and commander of the heavenly hosts, "
                    "guardian of souls, vanquisher of rebel spirits, servant in the house of the Divine King, "
                    "and our admirable conductor, deliver us from all evil who turn to you with confidence, "
                    "and enable us by your gracious protection to serve God more faithfully every day.\n\n"
                    "V/. Pray for us, O glorious St. Michael, Prince of the Church of Jesus Christ.\n"
                    "R/. That we may be made worthy of His promises."
            ),

            SizedBox(height: 40),
          ],
        ),
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
          color: Colors.deepPurple,
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
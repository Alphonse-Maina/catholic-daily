import 'package:flutter/material.dart';

import '../constants/colors.dart';

class HolySpiritChapletPage extends StatelessWidget {
  const HolySpiritChapletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Chaplet of the Holy Spirit"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 IMAGE
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/holy_spirit.webp",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                "CHAPLET IN HONOR OF THE HOLY SPIRIT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle("OPENING PRAYER"),
            const Text("""
O God, come to my assistance.
O Lord, make haste to help me.
Glory be to the Father...

In each mystery ask for a gift of the Holy Spirit.

Repeat seven times:
“Father, in the Name of Jesus, send forth Your Spirit and renew the world.”

Conclude each mystery with:
“O Mary, who by the work of the Holy Spirit conceived the Savior, pray for us.”
"""),

            const SizedBox(height: 24),

            _sectionTitle("THE SEVEN MYSTERIES"),

            _mystery("1. Spirit of Wisdom",
                "Come, O Spirit of Wisdom, detach us from earthly things and infuse in us a love and taste of heavenly things."),

            _mystery("2. Spirit of Understanding",
                "Come, O Spirit of Understanding, enlighten our minds with the light of Your eternal truth and the riches of holy thoughts."),

            _mystery("3. Spirit of Counsel",
                "Come, O Spirit of Counsel, make us docile to Your inspirations and guide us in the way of salvation."),

            _mystery("4. Spirit of Fortitude",
                "Come, O Spirit of Fortitude, give us strength, constancy, and victory in the battle against our spiritual enemies."),

            _mystery("5. Spirit of Knowledge",
                "Come, O Spirit of Knowledge, be the Master of our souls and help us to put into practice Your teachings."),

            _mystery("6. Spirit of Piety",
                "Come, O Spirit of Piety, come to live in our hearts to possess and sanctify all of our affections."),

            _mystery("7. Spirit of the Fear of the Lord",
                "Come, O Spirit of the Fear of the Lord, reign over our will and make us always disposed to suffer every evil rather than to sin."),

            const SizedBox(height: 24),

            _sectionTitle("INVOCATION TO MARY"),
            const Text("""
O most pure Virgin Mary, by your Immaculate Conception you were made a chosen tabernacle of Divinity by the Holy Spirit. Pray for us.
May the Divine Paraclete come soon to renew the face of the earth.
Hail Mary, full of grace...

O most pure Virgin Mary, by the Mystery of the Incarnation you became true Mother of God by the Holy Spirit. Pray for us.
May the Divine Paraclete come soon to renew the face of the earth.
Hail Mary, full of grace...

O most pure Virgin Mary, persevering in prayer with the Apostles in the Upper Room, you were abundantly inflamed by the Holy Spirit. Pray for us.
May the Divine Paraclete come soon to renew the face of the earth.
Hail Mary, full of grace...
"""),

            const SizedBox(height: 24),

            _sectionTitle("FINAL PRAYER"),
            const Text("""
Send Your Spirit, Lord, and transform us interiorly with Your gifts.
Create in us a new heart that we may please You and be conformed to Your will.
Through Christ our Lord.

Amen.
"""),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  static Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _mystery(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(body),
          const SizedBox(height: 6),
          const Text(
            "Repeat 7 times: “Father, in the Name of Jesus, send forth Your Spirit and renew the world.”",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 6),
          const Text(
            "Conclude: “O Mary, who by the work of the Holy Spirit conceived the Savior, pray for us.”",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
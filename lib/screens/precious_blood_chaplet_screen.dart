import 'package:flutter/material.dart';

import '../constants/colors.dart';

class PreciousBloodChapletPage extends StatelessWidget {
  const PreciousBloodChapletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Chaplet of the Precious Blood"),
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
                    "assets/images/precious_blood.webp",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// 🔥 TITLE
            const Center(
              child: Text(
                "CHAPLET OF THE PRECIOUS BLOOD",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle("HYMN"),
            const Text("""
Most Precious Blood of Jesus Christ
Most Precious Blood of Jesus Christ
Most Precious Blood of Jesus Christ
Most Precious Blood of Jesus Christ
Most Precious Blood, save the world.
"""),

            const SizedBox(height: 20),

            _sectionTitle("INVOCATION OF THE HOLY SPIRIT"),
            const Text("""
Come, Holy Spirit, fill the hearts of Your faithful and kindle in them the fire of Your love.

L: Send forth Your Spirit and they shall be created.
R: And You shall renew the face of the earth.

Let us Pray:

O God, Who did teach the hearts of the faithful by the light of the Holy Spirit, grant us by the same Spirit to be truly wise and ever rejoice in His consolations, through Christ Our Lord. Amen.
"""),

            const SizedBox(height: 20),

            _sectionTitle("OPENING PRAYERS"),
            const Text("""
Apostles Creed...

May the Precious Blood that pours out from the Sacred Head of Our Lord Jesus Christ cover us now and forever. Amen.

L: O most Precious Blood of Jesus Christ.
R: Heal the wounds in the most Sacred Heart of Jesus.

Our Father... 3 Hail Marys... Glory Be...
"""),

            const SizedBox(height: 24),

            _sectionTitle("THE FIRST MYSTERY"),
            const Text("""
The Nailing of the Right Hand of Our Lord Jesus

By the precious wound in Your right hand, may the Precious Blood save sinners of the whole world and convert many souls. Amen.

Our Father...
Hail Mary...
L: Precious Blood of Jesus Christ
R: Save us and the whole world. (12 times)
Glory Be...
"""),

            const SizedBox(height: 20),

            _sectionTitle("THE SECOND MYSTERY"),
            const Text("""
The Nailing of the Left Hand of Our Lord Jesus

May the Precious Blood save souls in Purgatory and protect the dying. Amen.

Our Father...
Hail Mary...
L: Precious Blood of Jesus Christ
R: Save us and the whole world. (12 times)
Glory Be...
"""),

            const SizedBox(height: 20),

            _sectionTitle("THE THIRD MYSTERY"),
            const Text("""
The Nailing of the Right Foot of Our Lord Jesus

May the Precious Blood cover the Church against evil. Amen.

Our Father...
Hail Mary...
L: Precious Blood of Jesus Christ
R: Save us and the whole world. (12 times)
Glory Be...
"""),

            const SizedBox(height: 20),

            _sectionTitle("THE FOURTH MYSTERY"),
            const Text("""
The Nailing of the Left Foot of Our Lord Jesus

May the Precious Blood protect us in all our ways. Amen.

Our Father...
Hail Mary...
L: Precious Blood of Jesus Christ
R: Save us and the whole world. (12 times)
Glory Be...
"""),

            const SizedBox(height: 20),

            _sectionTitle("THE FIFTH MYSTERY"),
            const Text("""
The Piercing of the Sacred Side of Our Lord Jesus

May the Precious Blood and water cure the sick, solve our problems, and teach us the way to eternal glory. Amen.

Our Father...
Hail Mary...
L: Precious Blood of Jesus Christ
R: Save us and the whole world. (12 times)
Glory Be...
"""),

            const SizedBox(height: 24),

            _sectionTitle("FINAL PRAYER"),
            const Text("""
O most Precious Blood of Jesus Christ, we honor, worship and adore You because of Your work of the everlasting covenant that brings peace to mankind.

Heal the wounds in the most Sacred Heart of Jesus.
Wash away the sins of the whole world.

Most Sacred Heart of Jesus, have mercy on us.
Immaculate Heart of Mary, pray for us.
St. Joseph, pray for us.

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
}
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class HolyWoundsChapletPage extends StatelessWidget {
  const HolyWoundsChapletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Chaplet of the Holy Wounds"),
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
                    "assets/images/holy_wounds.webp",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                "THE CHAPLET OF THE HOLY WOUNDS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle("OPENING PRAYERS"),
            const Text("""
On the crucifix and first three beads:

O Jesus, Divine Redeemer,
be merciful to us and to the whole world.
Amen.

Strong God, Holy God, Immortal God,
have mercy on us and on the whole world.
Amen.

Grace and Mercy, O my Jesus, during present dangers;
cover us with Your Precious Blood.
Amen.

Eternal Father, grant us mercy through the Blood of Jesus Christ, Your only Son;
grant us mercy we beseech You.
Amen, Amen, Amen.
"""),

            const SizedBox(height: 24),

            _sectionTitle("ON THE LARGE BEADS"),
            const Text("""
(The “Our Father” beads)

Eternal Father,
I offer You the Wounds of Our Lord, Jesus Christ,
to heal the wounds of our souls.
"""),

            const SizedBox(height: 24),

            _sectionTitle("ON THE SMALL BEADS"),
            const Text("""
(The “Hail Mary” beads)

My Jesus, pardon and mercy,
through the merits of Your Holy Wounds.
"""),

            const SizedBox(height: 40),

            const Center(
              child: Text(
                "Pray using the Marian Rosary.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

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
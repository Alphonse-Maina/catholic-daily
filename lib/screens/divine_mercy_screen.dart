import 'package:catholic_daily/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/reusable_widgets.dart';

class DivineMercyScreen extends StatelessWidget {
  const DivineMercyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Divine Mercy"),
        backgroundColor: AppColors.appBarBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            SectionHeader("For Each of the Five Decades"),

            PrayerText(
              'On each "Our Father" bead of the rosary, pray:',
            ),
            SizedBox(height: 8),
            VersicleResponse(
              versicle:
              'Eternal Father, I offer you the Body and Blood, soul and divinity of your dearly beloved Son, our Lord Jesus Christ,',
              response:
              'in atonement for our sins and those of the whole world.',
            ),

            SizedBox(height: 16),

            PrayerText(
              'On each of the 10 "Hail Mary" beads, pray:',
            ),
            SizedBox(height: 8),
            VersicleResponse(
              versicle: 'For the sake of his sorrowful Passion,',
              response: 'have mercy on us and on the whole world.',
            ),

            SizedBox(height: 24),

            SectionHeader("Conclusion"),

            PrayerText("Repeat three times:"),
            SizedBox(height: 8),
            PrayerBlock(
              'Holy God, Holy Mighty One, Holy Immortal One, have mercy on us and on the whole world.',
            ),

            SizedBox(height: 24),

            SectionHeader("Closing Prayer (optional)"),
            SmallReference("(Diary, 950)"),

            PrayerBlock(
              'Eternal God, in whom mercy is endless and the treasury of compassion inexhaustible, '
                  'look kindly upon us and increase your mercy in us, that in difficult moments we might '
                  'not despair nor become despondent, but with great confidence submit ourselves to your '
                  'holy will, which is Love and Mercy itself. Amen.',
            ),

            SizedBox(height: 24),

            SmallReference("(Roman Missal, Votive Mass of the Mercy of God)"),

            PrayerBlock(
              'O God, whose mercies are without number and whose treasure of goodness is infinite, '
                  'graciously increase the faith of the people consecrated to you, that all may grasp and '
                  'rightly understand by whose love they have been created, through whose Blood they have '
                  'been redeemed, and by whose Spirit they have been reborn. Through Christ our Lord. Amen.',
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
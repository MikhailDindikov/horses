import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/models/visual_aids_model.dart';
import 'package:horses/screens/analytics_screen.dart';
import 'package:horses/screens/calendar_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_images.dart';
import 'package:horses/utils/app_text.dart';

class VisualAidsScreen extends StatefulWidget {
  const VisualAidsScreen({super.key});

  @override
  State<VisualAidsScreen> createState() => _VisualAidsScreenState();
}

class _VisualAidsScreenState extends State<VisualAidsScreen> {
  final _models = [
    const VisualAidsModel(
      iconPath: AppIcons.ridingPosture,
      title: 'Riding posture',
      imgPath: AppImages.ridingPosture,
      text: 'Proper riding posture is the cornerstone of effective communication and balance in the saddle. A correct position aligns your body with the horse’s movement, minimizing strain on both rider and animal. Begin by sitting tall: imagine a straight line from your ear, through your shoulder, hip, and heel. Your shoulders should remain relaxed but pulled slightly back to open the chest, avoiding a rounded upper back. Engage your core muscles to stabilize your torso—this prevents collapsing forward or leaning backward. Your lower back should have a slight natural curve, not rigid or overly arched. Hands should be held just above the horse’s withers, elbows bent at a 90-degree angle, forming a straight line from the elbow through the reins to the bit. Legs should drape around the horse’s barrel, with knees softly bent and heels pressed downward to maintain a secure base. Weight should be distributed evenly across both seat bones, avoiding tipping to one side. Poor posture (e.g., slouching, gripping with knees, or “chair seat” legs) disrupts the horse’s balance and can lead to resistance or injury. Practice exercises like riding without stirrups or posting trot to build muscle memory. A balanced posture allows subtle aids (legs, seat, hands) to communicate clearly, fostering harmony and confidence.',
    ),
    const VisualAidsModel(
      iconPath: AppIcons.dna,
      title: 'Horse anatomy',
      imgPath: AppImages.dna,
      text: "Understanding basic horse anatomy is essential for safe riding and proper equipment use. The horse’s spine is a rigid structure supported by the back muscles, which bear the rider’s weight. Pressure from ill-fitting tack can cause pain or long-term damage, particularly over the withers (the bony ridge behind the neck) and the lumbar region. The horse’s legs are highly sensitive: tendons, ligaments, and joints (e.g., hocks, knees) absorb shock but are prone to injury from strain or improper footing. The mouth contains bars (gum ridges without teeth) where the bit sits; harsh rein aids can bruise this area. The horse’s center of gravity lies just behind the shoulders, shifting during movement—riders must adjust their weight to avoid unbalancing the horse. Key muscles include the gluteals (driving power), latissimus dorsi (back movement), and abdominal muscles (stability). A horse’s vision is panoramic, with blind spots directly in front and behind, so sudden movements in these zones can startle them. Knowledge of anatomy helps riders recognize signs of discomfort (e.g., tail swishing, pinned ears) and make informed decisions about training, tack, and care. Always prioritize the horse’s physical well-being to ensure a sustainable partnership.",
    ),
    const VisualAidsModel(
      iconPath: AppIcons.equipment,
      title: 'Equipment',
      imgPath: AppImages.equipment,
      text: "Tack refers to the gear used to ride and control a horse, divided into two main categories: English and Western. The saddle must fit both horse and rider, distributing weight evenly without pinching the horse’s spine. English saddles are lightweight with a close-contact design, while Western saddles have a deeper seat and horn for ranch work. The bridle includes the headstall, bit, and reins. Bits vary in severity: snaffles (jointed mouthpiece) are gentle, while curbs (leverage bits) amplify rein pressure. Reins connect to the bit and should be adjusted to allow light, consistent contact. The girth or cinch secures the saddle; overtightening can restrict breathing, while a loose girth risks saddle slippage. Additional gear includes saddle pads (to absorb sweat and reduce friction), breastplates (to stabilize the saddle), and martingales (to control head carriage). Protective boots or wraps shield the horse’s legs during work. For the rider, helmets, gloves, and boots with a heel (to prevent foot slipping through stirrups) are non-negotiable safety items. Always inspect tack for wear and tear, especially stitching and leather quality, to prevent accidents.",
    ),
    const VisualAidsModel(
      iconPath: AppIcons.setup,
      title: 'Equipment setup',
      imgPath: AppImages.setup,
      text: "Proper tack setup ensures comfort and safety for both horse and rider. Begin by grooming the horse thoroughly to remove dirt that could cause chafing. Place the saddle pad slightly forward over the withers, then slide it back into position to smooth the hair. Position the saddle centered on the horse’s back, ensuring it doesn’t rest on the shoulder blades. Secure the girth gradually, starting snug but not tight, and recheck after walking the horse, as muscles expand during warm-up. Attach the bridle carefully: slip the bit into the horse’s mouth by gently pressing your thumb into the corner (where there are no teeth). Adjust the headstall so the bit rests comfortably on the bars, creating one to two wrinkles at the corners of the mouth. Reins should be even in length, and the throatlatch (if present) must allow two fingers’ space beneath the jaw. Stirrups are adjusted to the rider’s leg length: when seated, the bottom of the stirrup iron should reach your ankle bone. For jumping, shorten stirrups 1–2 holes for a more secure two-point position. Always double-check buckles and billet straps for security. Poorly fitted equipment can lead to sores, behavioral issues, or accidents—take time to ensure every piece is correctly adjusted.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const CalendarScreen());
          },
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppIcons.calendar),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Visual aids',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AnalyticsScreen());
            },
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppIcons.analytics),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          itemBuilder: (context, index) => VisualAidsCard(
            model: _models[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
          itemCount: _models.length,
        ),
      ),
    );
  }
}

class VisualAidsCard extends StatelessWidget {
  final VisualAidsModel model;
  const VisualAidsCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => VisualAidsDetailScreen(
              model: model,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              model.iconPath,
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(
                model.title,
                style: AppText.h4.copyWith(color: AppColors.black),
              ),
            ),
            SvgPicture.asset(
              AppIcons.next,
            ),
          ],
        ),
      ),
    );
  }
}

class VisualAidsDetailScreen extends StatelessWidget {
  final VisualAidsModel model;
  const VisualAidsDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          model.title,
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  model.imgPath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                model.text,
                style: AppText.h5.copyWith(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

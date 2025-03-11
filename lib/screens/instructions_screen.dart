import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/models/instructions_model.dart';
import 'package:horses/screens/analytics_screen.dart';
import 'package:horses/screens/calendar_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_images.dart';
import 'package:horses/utils/app_text.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({super.key});

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final _model = [
    const InstructionsModel(
      title: 'Mounting and Dismounting Safely',
      imgPath: AppImages.b1,
      text:
          "Mounting a horse correctly is the foundation of safe riding. Begin by ensuring the horse is calm and standing still. Approach from the left side, hold the reins gently in your left hand, and grip the saddle’s pommel with your right. Place your left foot in the stirrup, push up with your right leg, and swing your right leg over the horse’s back without kicking. Lower yourself softly into the saddle to avoid startling the horse. Adjust your posture to sit upright, distributing weight evenly. Dismounting follows the reverse: remove your right foot from the stirrup, lean forward slightly, swing your leg back, and slide down gently, keeping hold of the reins. Always maintain contact with the horse to prevent it from moving unexpectedly. Practice this repeatedly to build confidence and fluidity. Focus on smooth movements to avoid unsettling the horse, and always check your equipment (girth, stirrups) before mounting.",
    ),
    const InstructionsModel(
      title: 'Holding and Using the Reins',
      imgPath: AppImages.b2,
      text:
          "Proper rein management is critical for communication. Hold the reins in both hands, thumbs on top, creating a straight line from elbow to bit. Maintain light, even contact—too loose, and you lose control; too tight, you confuse or hurt the horse. To steer, apply gentle pressure on one rein while supporting with the opposite leg (e.g., left rein + right calf for a left turn). To halt, squeeze both reins evenly while sitting deeper into the saddle. Avoid jerking or pulling abruptly, as this can trigger resistance. Beginners often “balance” on the reins, which strains the horse’s mouth; instead, rely on core strength and leg pressure for stability. Practice transitions (walk-halt-walk) to refine rein aids and develop a responsive partnership with the horse.",
    ),
    const InstructionsModel(
      title: 'Mastering Balance and Posture',
      imgPath: AppImages.b3,
      text:
          "A stable, aligned posture prevents fatigue and improves communication. Sit tall with shoulders back, chest open, and spine neutral—imagine a string pulling your head upward. Keep heels down, toes slightly raised, and knees softly bent to absorb movement. Engage your core to stabilize your torso, avoiding slouching or leaning forward. At the walk, let your hips move naturally with the horse’s rhythm. At the trot, practice “posting” (rising in sync with the horse’s diagonal strides) by pressing into your stirrups and lifting slightly. Balance exercises, like riding without stirrups at a walk, strengthen leg muscles and improve seat independence. Poor posture (e.g., rounded shoulders or gripping with knees) disrupts the horse’s movement and causes tension. Regular practice with mirrors or an instructor’s feedback helps correct alignment.",
    ),
    const InstructionsModel(
      title: 'Walking and Trotting Basics',
      imgPath: AppImages.b4,
      text:
          "Start at the walk, the slowest and most predictable gait. Focus on relaxing into the horse’s motion, letting your body sway gently. Use light leg pressure to maintain forward movement. Transition to the trot by squeezing both calves and clucking; the horse will shift into a bouncy two-beat gait. To post (rise) at the trot, lift slightly as the horse’s outside shoulder moves forward, then lower gently. Alternate between sitting and posting trot to build stamina and coordination. Keep your hands steady and avoid pulling the reins—let the horse’s head move freely. If unbalanced, grab the saddle’s pommel briefly, but aim to rely on leg and core strength. Practice circles and figure-eights to improve steering while maintaining gait consistency. Trotting develops rhythm and prepares you for faster gaits like the canter.",
    ),
    const InstructionsModel(
      title: 'Emergency Stops and Safety Awareness',
      imgPath: AppImages.b5,
      text:
          "Learning to stop quickly is vital for safety. To execute an emergency halt, sit deep, close your legs around the horse, and pull the reins toward your hips in a firm, steady motion—never yank. Pair this with a verbal cue like “Whoa!” to reinforce the command. Practice at a walk first, then progress to trotting. Always scan your environment for hazards (e.g., loose animals, uneven terrain) and maintain a safe distance from other riders. If the horse spooks, stay calm, shorten the reins, and redirect its attention with circles or transitions. Beginners should ride under supervision until they can reliably control speed and direction. Understanding horse body language (e.g., pinned ears, swishing tail) also helps anticipate reactions and prevent accidents.",
    ),
    const InstructionsModel(
      title: 'Cantering with Control',
      imgPath: AppImages.i1,
      text:
          "The canter is a three-beat gait requiring refined balance and timing. Begin in a corner of the arena, asking for the canter by applying inside leg pressure at the girth and outside leg slightly behind, while easing the inside rein. Sit deep and allow your hips to follow the horse’s rolling motion. Keep your shoulders level and avoid leaning forward. To slow, gradually sit heavier, apply half-halts (brief rein squeezes), and use your voice. Practice leads (the horse’s leading leg) by cantering on correct bends—left lead on left turns, right lead on right. Incorrect leads can cause imbalance, so learn to feel the rhythm and adjust. Canter transitions (trot-canter-trot) improve responsiveness. Avoid gripping with your knees, as this restricts the horse’s movement and causes stiffness.",
    ),
    const InstructionsModel(
      title: 'Jumping Small Obstacles',
      imgPath: AppImages.i2,
      text:
          "Introduce jumping with ground poles and crossrails. Approach in a balanced trot or steady canter, looking ahead—not down at the jump. Maintain even rein contact and a light seat (two-point position: torso leaned forward, hips above the saddle). As the horse takes off, fold your body slightly, allowing its neck to stretch. Land smoothly, returning to your seat and rebalancing. Start with single jumps, then progress to combinations. Analyze distances between fences to adjust stride length. Common mistakes include pulling the reins mid-air or collapsing the upper body, which disrupts the horse’s balance. Practice grids (series of spaced poles) to develop timing and confidence. Always warm up the horse properly and cool down after jumping sessions.",
    ),
    const InstructionsModel(
      title: 'Lateral Work and Collection',
      imgPath: AppImages.i3,
      text:
          "Lateral exercises like leg-yields and shoulder-in enhance suppleness and control. For a leg-yield, ask the horse to move sideways by applying inside leg pressure while keeping the outside rein steady. The horse should cross its legs without losing forward momentum. Shoulder-in involves bending the horse around your inside leg, with its shoulders angled inward—this improves flexibility. Collection (shortening the stride while maintaining energy) is achieved through half-halts and driving with the seat. These maneuvers require precise aids and patience; rushing can frustrate the horse. Work in short sessions, rewarding progress with walk breaks. Lateral work builds strength and prepares the horse for advanced dressage or trail challenges.",
    ),
    const InstructionsModel(
      title: 'Trail Riding Techniques',
      imgPath: AppImages.i4,
      text:
          "Trail riding demands adaptability. Practice riding uphill (lean forward, let reins slacken) and downhill (sit back, keep reins taut). Navigate obstacles like logs or water by staying calm and giving clear cues. In open spaces, control the horse’s speed with half-halts and transitions. Be mindful of footing—avoid slippery or rocky areas. Trail horses may spook at wildlife; desensitize them beforehand with exposure to flags, tarps, or noisy objects. Ride with a buddy for safety, and carry a phone and first-aid kit. Develop “feel” by reading the horse’s reactions to terrain changes. Trail riding builds trust and exposes you to real-world scenarios beyond the arena.",
    ),
    const InstructionsModel(
      title: 'Groundwork and Bonding',
      imgPath: AppImages.i5,
      text:
          "Groundwork strengthens your relationship and establishes respect. Use a halter and lead rope to practice leading, stopping, and backing up. Teach the horse to respond to pressure/release cues—for example, tapping its hindquarters to move sideways. Liberty work (free movement in a round pen) encourages the horse to follow your body language. Grooming sessions build trust; notice sensitive areas and reward calm behavior. Study natural horsemanship techniques to understand herd dynamics and communication. Groundwork translates to better ridden performance, as a horse that respects you on the ground is more attentive under saddle. Dedicate 10–15 minutes daily to these exercises for lasting results.",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          'Instruction',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Beginner',
                  style: AppText.h3.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InstructionsPageCard(model: _model[0]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[1]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[2]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[3]),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Intermediate',
                  style: AppText.h3.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InstructionsPageCard(model: _model[4]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[5]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[6]),
             const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Advanced',
                  style: AppText.h3.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InstructionsPageCard(model: _model[7]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[8]),
              const SizedBox(
                height: 12,
              ),
              InstructionsPageCard(model: _model[9]),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionsPageCard extends StatelessWidget {
  final InstructionsModel model;
  const InstructionsPageCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => InstructionsDetailScreen(model: model));
      },
      child: Container(
        height: 160,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              model.imgPath,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: AppText.h3.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionsDetailScreen extends StatelessWidget {
  final InstructionsModel model;
  const InstructionsDetailScreen({super.key, required this.model});

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
              const SizedBox(
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

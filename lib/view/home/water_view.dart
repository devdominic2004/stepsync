import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stepsync/common_widget/round_button.dart';

class WaterView extends StatelessWidget {
  const WaterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WaterTracker(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WaterTracker extends StatefulWidget {
  const WaterTracker({super.key});

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker>
    with SingleTickerProviderStateMixin {
  double currentIntake = 0;
  double targetIntake = 2000;
  final TextEditingController intakeController = TextEditingController();
  final TextEditingController targetController = TextEditingController(
    text: '2000',
  );
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    intakeController.dispose();
    targetController.dispose();
    super.dispose();
  }

  void updateValues() {
    setState(() {
      currentIntake =
          double.tryParse(intakeController.text.trim()) ?? currentIntake;
      targetIntake =
          double.tryParse(targetController.text.trim()) ?? targetIntake;
    });
  }

  @override
  Widget build(BuildContext context) {
    double fillPercent =
        targetIntake == 0 ? 0 : (currentIntake / targetIntake).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        title: const Text(
          "Water Tracker",
          style: TextStyle(
            color: Colors.white,
          ), // Explicitly set font color to white
        ),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Water animation
                AnimatedBuilder(
                  animation: _waveController,
                  builder: (context, child) {
                    return ClipOval(
                      child: CustomPaint(
                        size: const Size(250, 250),
                        painter: WaterPainter(
                          animationValue: _waveController.value,
                          fillPercent: fillPercent,
                        ),
                      ),
                    );
                  },
                ),
                // Center text with glow
                Text(
                  "${currentIntake.toStringAsFixed(0)} ml\n/\n${targetIntake.toStringAsFixed(0)} ml",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 235, 235, 235),
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                // Border circle
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                TextField(
                  controller: intakeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter water intake (ml)",
                    filled: true,
                    fillColor: Colors.indigo.shade800,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: targetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Set target intake (ml)",
                    filled: true,
                    fillColor: Colors.indigo.shade800,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                RoundButton(
                  title: "Update",
                  onPressed: updateValues,
                  type: RoundButtonType.bgGradient,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaterPainter extends CustomPainter {
  final double animationValue;
  final double fillPercent;

  WaterPainter({required this.animationValue, required this.fillPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.cyanAccent
          ..style = PaintingStyle.fill;

    double waveHeight = 8;
    double baseHeight = size.height * (1 - fillPercent);

    Path wavePath = Path();
    wavePath.moveTo(0, baseHeight);

    for (double x = 0; x <= size.width; x++) {
      double y =
          baseHeight +
          sin((x / size.width * 2 * pi) + (animationValue * 2 * pi)) *
              waveHeight;
      wavePath.lineTo(x, y);
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.drawPath(wavePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

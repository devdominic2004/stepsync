import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepView extends StatelessWidget {
  const StepView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: StepTracker());
  }
}

class StepTracker extends StatefulWidget {
  const StepTracker({super.key});

  @override
  StepTrackerState createState() => StepTrackerState();
}

class StepTrackerState extends State<StepTracker> {
  int _steps = 0;
  double _calories = 0;
  double _distance = 0;
  List<FlSpot> kcalData = [FlSpot(0, 0)];
  List<FlSpot> distanceData = [FlSpot(0, 0)];
  List<FlSpot> speedData = [FlSpot(0, 0)];
  int timeIndex = 0;
  Stream<StepCount>? _stepCountStream;
  int _initialSteps = 0;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    if (await Permission.activityRecognition.isGranted) {
      startStepTracking();
    } else {
      PermissionStatus status = await Permission.activityRecognition.request();
      if (status.isGranted) {
        startStepTracking();
      } else {
        debugPrint("Activity Recognition Permission not granted.");
      }
    }
  }

  void startStepTracking() async {
    try {
      // Get initial step count
      final initialStepCount = await Pedometer.stepCountStream.first;
      _initialSteps = initialStepCount.steps;

      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream!.listen(
        (StepCount event) {
          setState(() {
            // Calculate steps since app opened
            _steps = event.steps - _initialSteps;
            _distance = _steps * 0.0008; // assuming 0.8m per step
            _calories = _steps * 0.04; // rough estimate
            double speed = (_distance / (timeIndex + 1)) * 10;

            kcalData.add(FlSpot(timeIndex.toDouble(), _calories));
            distanceData.add(FlSpot(timeIndex.toDouble(), _distance * 100));
            speedData.add(FlSpot(timeIndex.toDouble(), speed));

            timeIndex++;
          });
        },
        onError: (error) {
          debugPrint('Step Count Stream Error: $error');
        },
      );
    } catch (e) {
      debugPrint('Error getting initial step count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243e)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.cyanAccent, width: 8),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_steps',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            shadows: [
                              Shadow(blurRadius: 10, color: Colors.cyanAccent),
                            ],
                          ),
                        ),
                        const Text(
                          'Steps',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_calories.toStringAsFixed(1)} kcal',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              '${_distance.toStringAsFixed(2)} Km',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: LineChart(
                    LineChartData(
                      backgroundColor: Colors.black,
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: kcalData,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.greenAccent,
                          dotData: FlDotData(show: false),
                        ),
                        LineChartBarData(
                          spots: distanceData,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.yellowAccent,
                          dotData: FlDotData(show: false),
                        ),
                        LineChartBarData(
                          spots: speedData,
                          isCurved: true,
                          barWidth: 2,
                          color: Colors.pinkAccent,
                          dotData: FlDotData(show: false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "-Kcal  ",
                  style: TextStyle(color: Colors.greenAccent, fontSize: 14),
                ),
                Text(
                  "-Distance  ",
                  style: TextStyle(color: Colors.yellowAccent, fontSize: 14),
                ),
                Text(
                  "-Speed",
                  style: TextStyle(color: Colors.pinkAccent, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

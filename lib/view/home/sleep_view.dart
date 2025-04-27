import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SleepView extends StatefulWidget {
  const SleepView({super.key});

  @override
  State<SleepView> createState() => _SleepClockState();
}

class _SleepClockState extends State<SleepView> {
  TimeOfDay? _bedTime;
  TimeOfDay? _wakeTime;
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _isRunning = false;
  double _needleValue = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startClock() {
    if (_bedTime == null) return;

    setState(() {
      _isRunning = true;
      _elapsedSeconds = 0;
      _wakeTime = null;
      _needleValue = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateClock();
      _updateNeedle();
    });
  }

  void _updateClock() {
    setState(() {
      _elapsedSeconds++;
    });
  }

  void _updateNeedle() {
    setState(() {
      // Move needle slightly each second (0.1 units per second)
      _needleValue = (_needleValue + 0.1) % 12;
    });
  }

  void _stopClock() {
    if (!_isRunning) return;

    _timer?.cancel();

    final now = DateTime.now();
    final wakeTime = TimeOfDay.fromDateTime(now);

    setState(() {
      _isRunning = false;
      _wakeTime = wakeTime;
    });

    _showResultsDialog();
  }

  void _showResultsDialog() {
    final sleepHours = _calculateSleepHours();
    if (sleepHours == null) return;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.orange, width: 2),
            ),
            title: const Text(
              'Sleep Results',
              style: TextStyle(color: Colors.orange, fontSize: 22),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildResultRow('Bedtime:', _formatTime(_bedTime!)),
                const SizedBox(height: 8),
                _buildResultRow('Wake Time:', _formatTime(_wakeTime!)),
                const SizedBox(height: 8),
                _buildResultRow(
                  'Duration:',
                  '${sleepHours.toStringAsFixed(2)} hours',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _getSleepQualityMessage(sleepHours),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK', style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  String _getSleepQualityMessage(double hours) {
    if (hours >= 8) return 'Excellent sleep! You got the recommended amount.';
    if (hours >= 7) return 'Good sleep, but could use a bit more.';
    if (hours >= 6) return 'Fair sleep. Try to get more rest.';
    return 'Insufficient sleep. Consider going to bed earlier.';
  }

  void _resetClock() {
    setState(() {
      _elapsedSeconds = 0;
      _isRunning = false;
      _needleValue = 0;
    });
    _timer?.cancel();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  double _timeToDouble(TimeOfDay time) {
    return time.hour + time.minute / 60.0;
  }

  double? _calculateSleepHours() {
    if (_bedTime == null || _wakeTime == null) return null;

    final bedDouble = _timeToDouble(_bedTime!);
    final wakeDouble = _timeToDouble(_wakeTime!);

    return (wakeDouble - bedDouble + 24) % 24;
  }

  String _formatElapsedTime(int seconds) {
    final hrs = seconds ~/ 3600;
    final mins = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hrs.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> _selectTime(BuildContext context, bool isBedTime) async {
    final initialTime = isBedTime ? _bedTime : _wakeTime;
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.orange,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.black,
              hourMinuteTextColor: Colors.white,
              hourMinuteColor: Colors.grey[900],
              dayPeriodTextColor: Colors.white,
              dayPeriodColor: Colors.grey[900],
              dialHandColor: Colors.orange,
              dialBackgroundColor: Colors.grey[900],
              hourMinuteTextStyle: const TextStyle(fontSize: 24),
              dayPeriodTextStyle: const TextStyle(fontSize: 14),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        if (isBedTime) {
          _bedTime = selectedTime;
          _wakeTime = null;
        } else {
          _wakeTime = selectedTime;
        }
        _resetClock();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sleepHours = _calculateSleepHours();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Sleep Tracker",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bedtime Selection
            Column(
              children: [
                Text(
                  "Select Bedtime",
                  style: TextStyle(color: Colors.orange.shade200, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectTime(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    _bedTime != null ? _formatTime(_bedTime!) : "Set Bedtime",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),

            // Wake Time Display
            if (_bedTime != null) ...[
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    "Wake Time",
                    style: TextStyle(
                      color: Colors.orange.shade200,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900],
                      foregroundColor:
                          _wakeTime != null ? Colors.white : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _wakeTime != null
                          ? _formatTime(_wakeTime!)
                          : "Press Stop to set",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 20),
            Expanded(
              child: SfRadialGauge(
                axes: [
                  RadialAxis(
                    minimum: 0,
                    maximum: 24,
                    interval: 3,
                    startAngle: 270,
                    endAngle: 270,
                    showLabels: true,
                    showTicks: false,
                    radiusFactor: 0.9,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 15,
                      color: Color(0xFF222222),
                    ),
                    axisLabelStyle: const GaugeTextStyle(color: Colors.white),
                    pointers: [
                      if (_bedTime != null)
                        MarkerPointer(
                          value: _timeToDouble(_bedTime!),
                          enableDragging: false,
                          markerType: MarkerType.circle,
                          color: Colors.orange,
                          markerHeight: 20,
                          markerWidth: 20,
                        ),
                      if (_wakeTime != null)
                        MarkerPointer(
                          value: _timeToDouble(_wakeTime!),
                          enableDragging: false,
                          markerType: MarkerType.circle,
                          color: Colors.orange,
                          markerHeight: 20,
                          markerWidth: 20,
                        ),
                      if (_bedTime != null && _wakeTime != null)
                        RangePointer(
                          value: _calculateSleepHours() ?? 0,
                          cornerStyle: CornerStyle.bothFlat,
                          width: 15,
                          color: Colors.orange.withOpacity(0.5),
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          enableAnimation: true,
                        ),
                      // Ticking needle (only visible when running)
                      if (_isRunning)
                        NeedlePointer(
                          value: _needleValue,
                          needleLength: 0.7,
                          needleStartWidth: 1,
                          needleEndWidth: 5,
                          needleColor: Colors.white,
                          knobStyle: const KnobStyle(
                            knobRadius: 0.08,
                            color: Colors.orange,
                            borderWidth: 0.02,
                            borderColor: Colors.white,
                          ),
                          tailStyle: const TailStyle(
                            color: Colors.grey,
                            width: 4,
                            length: 0.2,
                          ),
                        ),
                    ],
                    annotations: [
                      GaugeAnnotation(
                        angle: 90,
                        positionFactor: 0.2,
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatElapsedTime(_elapsedSeconds),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Start/Stop buttons
            if (_bedTime != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? null : _startClock,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.grey : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Start", style: TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton(
                    onPressed: _isRunning ? _stopClock : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.red : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Stop", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}

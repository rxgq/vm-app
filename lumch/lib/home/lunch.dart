import 'package:flutter/material.dart';
import 'dart:async';

class LunchView extends StatefulWidget {
  const LunchView({super.key});

  @override
  State<LunchView> createState() => _LunchViewState();
}

class _LunchViewState extends State<LunchView> {
  late Timer _timer;
  Duration _timeRemaining = const Duration();
  bool _isCelebrating = false;
  bool _resetting = false;
  Duration _resettingTime = const Duration(minutes: 5);
  Duration _celebrationTime = const Duration(minutes: 30);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final now = DateTime.now();
    final target = DateTime(now.year, now.month, now.day, 12, 00, 00);
    
    // If it's already past 12:00 PM today, set the target to 12:00 PM tomorrow
    if (now.isAfter(target)) {
      target.add(const Duration(days: 1));
    }
    
    setState(() {
      _timeRemaining = target.difference(now);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        final now = DateTime.now();
        _timeRemaining = target.difference(now);

        if (_timeRemaining.isNegative) {
          _timer.cancel();
          _celebrateLunch();
        }
      });
    });
  }

  void _celebrateLunch() {
    setState(() {
      _isCelebrating = true;
      _celebrationTime = const Duration(minutes: 30);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _celebrationTime -= const Duration(seconds: 1);
        if (_celebrationTime.isNegative || _celebrationTime == Duration.zero) {
          _timer.cancel();
          _isCelebrating = false;
          _resetting = true;
          _resettingTime = const Duration(minutes: 5);

          _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
            setState(() {
              _resettingTime -= const Duration(seconds: 1);
              if (_resettingTime.isNegative || _resettingTime == Duration.zero) {
                _timer.cancel();
                _resetting = false;
                _startTimer();
              }
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _timeRemaining.inHours.toString().padLeft(2, '0');
    final minutes = (_timeRemaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_timeRemaining.inSeconds % 60).toString().padLeft(2, '0');
    final resetMinutes = _resettingTime.inMinutes.toString().padLeft(2, '0');
    final resetSeconds = (_resettingTime.inSeconds % 60).toString().padLeft(2, '0');
    final celebrationMinutes = _celebrationTime.inMinutes.toString().padLeft(2, '0');
    final celebrationSeconds = (_celebrationTime.inSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _isCelebrating
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.celebration,
                  size: 100,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  'It\'s Lunchtime! Celebrate!',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Celebration ends in $celebrationMinutes:$celebrationSeconds',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          : _resetting 
            ? Text(
                'Timer resetting in $resetMinutes:$resetSeconds...',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$hours:$minutes:$seconds',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "until lunch...",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.7
                  ),
                ),
              ],
            ),
      ),
    );
  }
}

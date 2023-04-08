import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const FiveSeconds = 5;
  int totalSeconds = FiveSeconds;
  int totalPomodors = 0;
  late Timer timer;
  bool isRunning = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodors = totalPomodors + 1;
        isRunning = false;
        totalSeconds = FiveSeconds;
        timer.cancel();
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      isRunning = false;
      totalSeconds = FiveSeconds;
      totalPomodors = 0;
      timer.cancel();
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    String a = duration.toString().substring(2, 7);
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 80,
                  color: Theme.of(context).cardColor,
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                  icon: isRunning
                      ? const Icon(Icons.pause_circle_filled_outlined)
                      : const Icon(Icons.play_circle_outline),
                ),
                IconButton(
                  iconSize: 80,
                  color: Theme.of(context).cardColor,
                  onPressed: onResetPressed,
                  icon: const Icon(Icons.replay_circle_filled_outlined),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, 35),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(50),
                        color: Theme.of(context).cardColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Pomodors",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                          Text(
                            "$totalPomodors",
                            style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

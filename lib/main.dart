import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:timer_sample/controller.dart';
import 'package:get/get.dart';
import 'package:timer_sample/timer_status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends GetView<Controller> {
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => Controller());
    controller.checkTimerStatus();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (controller.timeElapsed.value is Checking)
                  return SizedBox();
                else if ((controller.timeElapsed.value is Counting)) {
                  int elapsed =
                      (controller.timeElapsed.value as Counting).elapsedTime;
                  return CircularCountDownTimer(
                    duration: 60,
                    initialDuration: elapsed,
                    controller: _controller,
                    onComplete: () {
                      controller.stopTimer();
                    },
                    isReverse: true,
                    isReverseAnimation: true,
                    width: 50,
                    height: 50,
                    fillColor: Colors.blue,
                    ringColor: Colors.black,
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        controller.startTimer();
                        // when a timer still has elapsed time when the application starts,
                        // it won't start automatically. start() must be called to allow
                        // the timer to start using the initialDuration
                        _controller.start();
                      },
                      child: Text('start'));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:analog_clock/analog_clock.dart';

class AnalogClockWidget extends StatelessWidget {
  const AnalogClockWidget({
    Key? key,
    required this.isDay,
  }) : super(key: key);

  final bool isDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Center(
          child: AnalogClock(
            decoration: BoxDecoration(
              border: Border.all(
                width: 10.0,
                color: Colors.white.withOpacity(0.075),
              ),
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            width: 140.0,
            isLive: true,
            hourHandColor: Colors.white,
            minuteHandColor: Colors.white60,
            showSecondHand: false,
            numberColor: Colors.white,
            showNumbers: false,
            textScaleFactor: 1.4,
            showTicks: true,
            tickColor: Colors.white.withOpacity(0.2),
            showDigitalClock: false,
            datetime: DateTime.now(),
            showAllNumbers: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: Center(
            child: Icon(
              isDay ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}

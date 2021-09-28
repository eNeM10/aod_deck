import 'package:flutter/material.dart';
class DigitalTimeWidget extends StatelessWidget {
  const DigitalTimeWidget({
    Key? key,
    required this.timeHr,
    required this.blinkColon,
    required this.timeMin,
  }) : super(key: key);

  final String timeHr;
  final bool blinkColon;
  final String timeMin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timeHr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        ),
        Text(
          ':',
          style: blinkColon
              ? const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                )
              : const TextStyle(
                  color: Colors.white38,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
        ),
        Text(
          timeMin,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DateDayWidget extends StatelessWidget {
  const DateDayWidget({
    Key? key,
    required this.day,
    required this.date,
  }) : super(key: key);

  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          ', $date',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

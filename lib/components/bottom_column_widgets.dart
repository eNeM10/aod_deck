import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftColumnWidget extends StatelessWidget {
  const LeftColumnWidget({
    Key? key,
    required this.temperature,
    required this.feelsLike,
    required this.weatherDesc,
    required this.weatherIcon,
  }) : super(key: key);

  final int temperature;
  final int feelsLike;
  final String weatherDesc;
  final IconData weatherIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$temperature°C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Text(
          'Feels Like $feelsLike°C',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Row(
          children: [
            Text(
              '$weatherDesc ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Icon(
              weatherIcon,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ],
    );
  }
}

class RightColumnWidget extends StatelessWidget {
  const RightColumnWidget({
    Key? key,
    required this.windSpeed,
    required this.windDegrees,
    required this.humidity,
    required this.pressure,
  }) : super(key: key);

  final int windSpeed;
  final int windDegrees;
  final int humidity;
  final int pressure;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Wind: $windSpeed km/h ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Transform.rotate(
              angle: (windDegrees - 180) * pi / 180,
              child: const Icon(
                FontAwesomeIcons.arrowAltCircleUp,
                color: Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
        Text(
          'Humidity: $humidity%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Text(
          'Pressure: $pressure mb',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

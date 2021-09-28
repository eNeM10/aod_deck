import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

import 'location.dart';
import 'networking.dart';

const String appID = '861069d4a2fb70d050c815d2cd1c0ffa';
const String units = 'metric';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appID=$appID&units=$units');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition, bool isDay) {
    if (condition < 300) {
      if (isDay) {
        return WeatherIcons.day_thunderstorm;
      } else {
        return WeatherIcons.night_thunderstorm;
      }
    } else if (condition < 400) {
      if (isDay) {
        return WeatherIcons.day_sprinkle;
      } else {
        return WeatherIcons.night_sprinkle;
      }
    } else if (condition < 502) {
      if (isDay) {
        return WeatherIcons.day_rain;
      } else {
        return WeatherIcons.night_rain;
      }
    } else if (condition < 600) {
      if (isDay) {
        return WeatherIcons.day_rain_mix;
      } else {
        return WeatherIcons.night_rain_mix;
      }
    } else if (condition < 700) {
      if (isDay) {
        return WeatherIcons.day_snow;
      } else {
        return WeatherIcons.night_snow;
      }
    } else if (condition < 800) {
      if (isDay) {
        return WeatherIcons.day_haze;
      } else {
        return WeatherIcons.night_fog;
      }
    } else if (condition == 800) {
      if (isDay) {
        return WeatherIcons.day_sunny;
      } else {
        return WeatherIcons.night_clear;
      }
    } else if (condition <= 804) {
      if (isDay) {
        return WeatherIcons.day_cloudy;
      } else {
        return WeatherIcons.night_cloudy;
      }
    } else {
      if (isDay) {
        return WeatherIcons.alien;
      } else {
        return WeatherIcons.alien;
      }
    }
  }
}

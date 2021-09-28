import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intervalprogressbar/intervalprogressbar.dart';

import 'package:weather_icons/weather_icons.dart';
import 'package:wakelock/wakelock.dart';

import 'components/analog_clock_widget.dart';
import 'components/bottom_column_widgets.dart';
import 'components/date_day_widget.dart';
import 'components/digital_time_widget.dart';

import 'services/time_formatter.dart';
import 'services/weather.dart';

extension StringExtension on String {
  String capitalizeFirst() {
    // ignore: unnecessary_this
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  Wakelock.enable();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String timeHr = 'error';
  String timeMin = 'error';
  String timeSec = 'error';
  String date = 'error';
  String day = 'error';
  bool blinkColon = true;

  dynamic weatherData;

  int temperature = 0;
  int condition = 0;
  String cityName = 'error';
  int feelsLike = 0;
  int humidity = 0;
  int pressure = 0;
  int windSpeed = 0;
  String description = 'error';
  int maxTemperature = 0;
  int minTemperature = 0;
  int windDegrees = 0;
  String sunsetTime = 'error';
  String sunriseTime = 'error';
  DateTime sunset = DateTime.now();
  DateTime sunrise = DateTime.now();
  bool isDay = false;
  IconData weatherIcon = WeatherIcons.alien;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    loadData();
  }

  void loadData() async {
    setState(() {
      loading = true;
    });
    getTime();
    await getLocationData();
    setState(() {
      loading = false;
    });
    Timer.periodic(const Duration(seconds: 1), (Timer t) => getTime());
    Timer.periodic(const Duration(minutes: 1), (Timer t) => getTimeOfDay());
    Timer.periodic(const Duration(minutes: 10), (Timer t) => getLocationData());
  }

  void getTimeOfDay() {
    setState(() {
      DateTime time = DateTime.now();
      if (sunrise.isAfter(time)) {
        isDay = false;
      } else if (sunset.isAfter(time)) {
        isDay = true;
      } else if (sunset.isBefore(time)) {
        isDay = false;
      }
    });
  }

  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedHr = formatTimeHour(now);
    final String formattedMin = formatTimeMinute(now);
    final String formattedSec = formatTimeSecond(now);
    final String formattedDate = formatDate(now);
    final String formattedDay = formatDay(now);
    setState(() {
      blinkColon = !blinkColon;
      timeHr = formattedHr;
      timeMin = formattedMin;
      timeSec = formattedSec;
      date = formattedDate;
      day = formattedDay;
    });
  }

  void updateWeatherData() {
    setState(() {
      if (weatherData == null) {
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      var feelsLikeTemp = weatherData['main']['feels_like'];
      feelsLike = feelsLikeTemp.round();
      humidity = weatherData['main']['humidity'];
      var tempWindSpeed = weatherData['wind']['speed'];
      tempWindSpeed *= 3.6;
      windSpeed = tempWindSpeed.toInt();
      var tempPressure = weatherData['main']['pressure'];
      pressure = tempPressure.toInt();
      String tempDescription = weatherData['weather'][0]['description'];
      description = tempDescription.capitalizeFirst();
      var maxTemp = weatherData['main']['temp_max'];
      maxTemperature = maxTemp.toInt();
      var minTemp = weatherData['main']['temp_min'];
      minTemperature = minTemp.toInt();
      var tempWindDegrees = weatherData['wind']['deg'];
      windDegrees = tempWindDegrees.toInt();
      var tempSunriseEpoch = weatherData['sys']['sunrise'] * 1000;
      var tempSunsetEpoch = weatherData['sys']['sunset'] * 1000;
      sunriseTime = DateTime.fromMillisecondsSinceEpoch(tempSunriseEpoch)
              .hour
              .toString() +
          ':' +
          DateTime.fromMillisecondsSinceEpoch(tempSunriseEpoch)
              .minute
              .toString();
      sunsetTime =
          DateTime.fromMillisecondsSinceEpoch(tempSunsetEpoch).hour.toString() +
              ':' +
              DateTime.fromMillisecondsSinceEpoch(tempSunsetEpoch)
                  .minute
                  .toString();

      sunrise = DateTime.fromMillisecondsSinceEpoch(tempSunriseEpoch);
      sunset = DateTime.fromMillisecondsSinceEpoch(tempSunsetEpoch);
      DateTime time = DateTime.now();
      if (sunrise.isAfter(time)) {
        isDay = false;
      } else if (sunset.isAfter(time)) {
        isDay = true;
      } else if (sunset.isBefore(time)) {
        isDay = false;
      }
      weatherIcon = WeatherModel().getWeatherIcon(condition, isDay);
    });
  }

  Future getLocationData() async {
    weatherData = await WeatherModel().getLocationWeather();
    updateWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.black,
            color: Colors.white,
          ))
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Expanded(
                    flex: 3,
                    child: AnalogClockWidget(isDay: isDay),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DigitalTimeWidget(
                          timeHr: timeHr,
                          blinkColon: blinkColon,
                          timeMin: timeMin,
                        ),
                        DateDayWidget(
                          day: day,
                          date: date,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              LeftColumnWidget(
                                temperature: temperature,
                                feelsLike: feelsLike,
                                weatherDesc: description,
                                weatherIcon: weatherIcon,
                              ),
                              RightColumnWidget(
                                windSpeed: windSpeed,
                                windDegrees: windDegrees,
                                humidity: humidity,
                                pressure: pressure,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: IntervalProgressBar(
                      direction: IntervalProgressDirection.horizontal,
                      max: 96,
                      progress: (DateTime.now().hour * 4) +
                          (DateTime.now().minute ~/ 15),
                      intervalSize: 1,
                      size: Size(MediaQuery.of(context).size.width - 100, 10),
                      highlightColor: Colors.transparent,
                      defaultColor: Colors.transparent,
                      intervalColor: Colors.white.withOpacity(0.25),
                      intervalHighlightColor: Colors.white,
                      reverse: false,
                      radius: 0,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Icon(
                                WeatherIcons.sunrise,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            Text(
                              '  ${formatTimeHourMin(sunrise)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${formatTimeHourMin(sunset)} ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Icon(
                                WeatherIcons.sunset,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

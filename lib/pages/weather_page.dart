import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/services/weather_servieces.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherservice = WeatherService('20b41e343bfa429fe9b5aad8adbd8409');

  //fetch
  Weather? _wheather;

  _fetchweather() async {
    String? cord;
    _weatherservice.getlat().then((value) {
      cord = value;
    });
    // get weather for city
    try {
      final weather =
          await _weatherservice.getWeather(cord ?? '13.174482&lon=77.531605');
      setState(() {
        _wheather = weather;
      });
    }
// any errors
    catch (e) {
      print(e);
    }
  }

  String getAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cloudy.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'smoke':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloudy.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _wheather?.cityName ?? "loading city ..",
              maxLines: 4,
            ),
            Lottie.asset(getAnimation(_wheather!.mainCondition)),
            Text('${_wheather?.temperature ?? 0.0}'),
            Text(_wheather?.mainCondition ?? " "),
          ],
        ),
      ),
    );
  }
}

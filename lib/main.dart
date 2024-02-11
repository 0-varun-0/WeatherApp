import 'package:flutter/material.dart';
import 'package:weatherapp/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}

//apikey = 20b41e343bfa429fe9b5aad8adbd8409
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}

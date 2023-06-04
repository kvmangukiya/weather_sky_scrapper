import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/controllers/theme_provider.dart';
import '../../models/color_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacementNamed('home_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context, listen: false)
      ..checkConnectivity()
      ..getBookMark();

    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(193, 139, 217, 1),
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(ColorModel.splashBkg),
                opacity: 1),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 500),
              CircularProgressIndicator(color: Colors.white70),
              Text("Weather App",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textScaleFactor: 2),
              Text(
                "Made with love 💕 in India",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

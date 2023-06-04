import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/controllers/current_weather_provider.dart';
import 'package:weather_sky_scrapper/controllers/search_city_provider.dart';
import 'package:weather_sky_scrapper/views/screens/city_weather.dart';
import 'package:weather_sky_scrapper/views/screens/home_screen.dart';
import 'controllers/theme_provider.dart';
import 'views/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CurrentWeatherProvider()),
        ChangeNotifierProvider(create: (context) => SearchCityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bhagavad Gita',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(),
          primarySwatch: Colors.purple,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: Colors.white,
          ),
        ), // themeMode: ThemeMode.system,
        themeMode: (themeProvider.isDark) ? ThemeMode.dark : ThemeMode.light,
        routes: {
          "/": (context) => const SplashScreen(),
          "home_screen": (context) => const HomeScreen(),
          "city_weather": (context) => const CityWeather(),
        });
  }
}

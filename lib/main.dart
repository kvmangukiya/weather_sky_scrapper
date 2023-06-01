import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/views/screens/home_screen.dart';
import 'controllers/theme_provider.dart';
import 'views/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        // ChangeNotifierProvider(create: (context) => GitaProvider()),
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
          primarySwatch: Colors.blue,
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
        });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/utils/functions.dart';
import 'package:weather_sky_scrapper/views/screens/city_bookmark.dart';
import '../../controllers/theme_provider.dart';
import '../../models/color_model.dart';
import 'home_city_weather.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorModel.pageBkgColor,
          image: DecorationImage(
            image: AssetImage(ColorModel.cityBkg),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {
                      const CityBookMark();
                    },
                    icon: const Icon(Icons.bookmark),
                    color: ColorModel.primaryColor,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: appText(
                          text: "Settings",
                          fw: FontWeight.bold,
                          size: 22,
                          alignCenter: true),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      const HomeCityWeather();
                    },
                    icon: const Icon(Icons.home_filled),
                    color: ColorModel.primaryColor,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            Divider(
              height: 16,
              thickness: 2,
              color: (themeProvider.isDark)
                  ? Colors.white30
                  : ColorModel.primaryColor.withOpacity(0.5),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ListTile(
                  leading: Icon(
                    themeProvider.isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: ColorModel.primaryColor,
                  ),
                  title: appText(text: "Theme", fw: FontWeight.w500, size: 20),
                  subtitle: appText(
                      text:
                          (themeProvider.isDark) ? "Dark Theme" : "Light Theme",
                      size: 16),
                  trailing: Switch(
                    value: themeProvider.isDark,
                    onChanged: (bool value) {
                      themeProvider.setDarkTheme(value);
                    },
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: ColorModel.primaryColor,
                    activeColor: Colors.white,
                  ),
                  onTap: () {
                    themeProvider.setDarkTheme(!themeProvider.isDark);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

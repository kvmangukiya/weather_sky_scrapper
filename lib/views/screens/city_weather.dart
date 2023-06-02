import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/controllers/current_weather_provider.dart';
import 'package:weather_sky_scrapper/utils/functions.dart';
import '../../models/color_model.dart';

class CityWeather extends StatelessWidget {
  const CityWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorModel.pageBkgColor,
        image: DecorationImage(
            image: AssetImage("assets/images/citybkg.jpg"),
            fit: BoxFit.fitHeight),
      ),
      child: Consumer<CurrentWeatherProvider>(
        builder: (context, cwp, child) => FutureBuilder(
          // future: cwp.cityCurrentWeather("Surat"),
          future: cwp.ipCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var city = snapshot.data!.location?.name;
              var country = snapshot.data!.location?.country;
              var temp = snapshot.data!.current?.tempC!.round();
              var feelTemp = snapshot.data!.current?.feelslikeC;
              var windDegree = snapshot.data!.current?.windDegree;
              var windDir = snapshot.data!.current?.windDir;
              var speed = snapshot.data!.current?.windKph;
              var cIconUrl = "https:${snapshot.data!.current?.condition?.icon}";
              var cText = snapshot.data!.current?.condition?.text;
              var temperature = snapshot.data!.current?.tempC;
              var humidity = snapshot.data!.current?.humidity;
              var pressure = snapshot.data!.current?.pressureMb;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText(
                              text: "$city ($country)",
                              size: 30,
                              fw: FontWeight.bold),
                          RotationTransition(
                            turns: AlwaysStoppedAnimation(windDegree! / 360),
                            child: const Icon(Icons.north,
                                color: ColorModel.primaryColor),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText(size: 50, text: '$temp°'),
                          appText(
                              size: 20,
                              text: '$feelTemp°',
                              color: ColorModel.darkGreyColor),
                        ],
                      ),
                      appText(text: "$cText", fw: FontWeight.w500),
                      Image.network(cIconUrl, scale: 0.5),
                      //wind
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: appText(
                                size: 20,
                                color: ColorModel.primaryColor.withOpacity(.8),
                                text: 'Wind',
                                fw: FontWeight.bold,
                              ),
                            ),
                            Card(
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customListTile(
                                      text: '$windDir',
                                      first: 'Speed:',
                                      second: ' $speed km/h',
                                      icon: Icons.air,
                                      iconColor: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Barometer
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: appText(
                                size: 20,
                                color: ColorModel.primaryColor.withOpacity(.8),
                                text: 'Barometer',
                                fw: FontWeight.bold,
                              ),
                            ),
                            Card(
                              color: ColorModel.bgGreyColor.withOpacity(0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    customListTile(
                                      first: 'Temperature:',
                                      second: ' $temperature °C',
                                      icon: Icons.thermostat,
                                      iconColor: Colors.orange,
                                    ),
                                    customListTile(
                                      first: 'Humidity:',
                                      second: ' $humidity %',
                                      icon: Icons.water_drop_outlined,
                                      iconColor: Colors.blueGrey,
                                    ),
                                    customListTile(
                                      first: 'Pressure:',
                                      second: ' $pressure hPa',
                                      icon: Icons.speed,
                                      iconColor: Colors.red[300]!,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child:
                    CircularProgressIndicator(color: ColorModel.primaryColor),
              );
            }
          },
        ),
      ),
    );
  }
}

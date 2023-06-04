import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_sky_scrapper/utils/functions.dart';
import '../../controllers/current_weather_provider.dart';
import '../../controllers/search_city_provider.dart';
import '../../controllers/theme_provider.dart';
import '../../models/color_model.dart';

class CityBookMark extends StatefulWidget {
  const CityBookMark({Key? key}) : super(key: key);

  @override
  State<CityBookMark> createState() => _CityBookMarkState();
}

class _CityBookMarkState extends State<CityBookMark> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Container(
        padding: const EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorModel.pageBkgColor,
          image: DecorationImage(
            image: AssetImage(ColorModel.cityBkg),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: ThemeProvider.internet
            ? Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: 60,
                    child: TextField(
                      controller: search,
                      onSubmitted: (val) {
                        setState(() {});
                      },
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle().copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorModel.primaryColor),
                      decoration: InputDecoration(
                        hintText: "Search for a city",
                        hintStyle: const TextStyle().copyWith(
                            color: ColorModel.primaryColor.withOpacity(0.5)),
                        border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: ColorModel.primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                                color: ColorModel.primaryColor, width: 1.5)),
                        suffixIcon: IconButton(
                          color: ColorModel.primaryColor,
                          icon: const Icon(Icons.search_outlined),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                        labelStyle:
                            const TextStyle().copyWith(color: Colors.grey),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Expanded(
                    child: search.text == ""
                        ? (themeProvider.cityBookMark.isNotEmpty)
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: themeProvider.cityBookMark.map((e) {
                                    return (e != "")
                                        ? bookMarkCityWeather(context, e)
                                        : const SizedBox();
                                  }).toList(),
                                ),
                              )
                            : Center(
                                child:
                                    appText(text: "Bookmark list is empty..."),
                              )
                        : Consumer<SearchCityProvider>(
                            builder: (context, scp, child) => FutureBuilder(
                              future: scp.searchCity(search.text),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return (snapshot.data!.isNotEmpty)
                                      ? SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: snapshot.data!.map((e) {
                                              return (e.url != null)
                                                  ? bookMarkCityWeather(
                                                      context, e.url as String)
                                                  : const SizedBox();
                                            }).toList(),
                                          ),
                                        )
                                      : Center(
                                          child: appText(
                                              text: "Data not found..."),
                                        );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: ColorModel.primaryColor),
                                  );
                                }
                              },
                            ),
                          ),
                  ),
                  const SizedBox(height: 90),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    appText(text: "Internet connection is not available..."),
                    IconButton(
                        onPressed: () {
                          themeProvider.checkConnectivity();
                        },
                        icon: Icon(Icons.replay_circle_filled_rounded,
                            color: ColorModel.primaryColor),
                        iconSize: 35),
                  ],
                ),
              ),
      ),
    );
  }

  Widget bookMarkCityWeather(BuildContext context, String city) {
    return Consumer<CurrentWeatherProvider>(
      builder: (context, cwp, child) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('city_weather', arguments: city);
        },
        child: FutureBuilder(
          // future: cwp.cityCurrentWeather("Surat"),
          future: cwp.cityCurrentWeather(city),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var city = snapshot.data!.location?.name;
              var country = snapshot.data!.location?.country;
              var temp = snapshot.data!.current?.tempC!.round();
              var cIconUrl = "https:${snapshot.data!.current?.condition?.icon}";
              var cText = snapshot.data!.current?.condition?.text;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: MediaQuery.of(context).size.width - 16,
                  height: (MediaQuery.of(context).size.width - 16) * 0.47368421,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ColorModel.bookMarkBkg),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 16),
                            colorText(size: 40, text: '$temp°'),
                            colorText(
                                text: "$city, $country",
                                size: 16,
                                fw: FontWeight.w500),
                            const SizedBox(height: 19),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(cIconUrl, scale: 0.70),
                            colorText(
                              text: "$cText",
                              size: 16,
                              fw: FontWeight.w400,
                              alignCenter: true,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
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

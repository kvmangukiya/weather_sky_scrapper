import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import '../../models/color_model.dart';
import '../../controllers/theme_provider.dart';
import 'home_city_weather.dart';
import 'settings.dart';
import 'city_bookmark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeCityWeather(),
    const CityBookMark(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorModel.pageBkgColor,
            image: DecorationImage(
              image: AssetImage(ColorModel.cityBkg),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: List.generate(
                bottomBarPages.length, (index) => bottomBarPages[index]),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                /// Provide NotchBottomBarController
                notchBottomBarController: _controller,
                color: ColorModel.primaryColor,
                showLabel: false,
                notchColor: ColorModel.notchColor,

                /// restart app if you change removeMargins
                removeMargins: false,
                bottomBarWidth: 500,
                durationInMilliSeconds: 300,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: const Icon(
                      Icons.home_filled,
                      color: ColorModel.notchColor,
                    ),
                    activeItem: Icon(
                      Icons.home_filled,
                      color: ColorModel.primaryColor,
                    ),
                    itemLabel: 'Page 1',
                  ),
                  BottomBarItem(
                    inActiveItem: const Icon(
                      Icons.saved_search,
                      color: ColorModel.notchColor,
                    ),
                    activeItem: Icon(
                      Icons.saved_search,
                      color: ColorModel.primaryColor,
                    ),
                    itemLabel: 'Page 2',
                  ),
                  BottomBarItem(
                    inActiveItem: const Icon(
                      Icons.settings,
                      color: ColorModel.notchColor,
                    ),
                    activeItem: Icon(
                      Icons.settings,
                      color: ColorModel.primaryColor,
                    ),
                    itemLabel: 'Page 3',
                  ),
                ],
                onTap: (index) {
                  /// perform action on tab change and to update pages you can update pages without pages
                  ThemeProvider.selPageIndex = index;
                  _pageController.jumpToPage(index);
                },
              )
            : null,
      ),
    );
  }
}

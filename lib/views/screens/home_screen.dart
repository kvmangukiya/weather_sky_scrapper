import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../controllers/theme_provider.dart';
import '../../models/colorModel.dart';
import '../../utils/functions.dart';

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

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const Page1(),
    const Page2(),
    const Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: ColorModel.bottomNavigationBarBkgColor,
              showLabel: false,
              notchColor: ColorModel.notchColor,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 300,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: ColorModel.notchColor,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: ColorModel.bottomNavigationBarBkgColor,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.saved_search,
                    color: ColorModel.notchColor,
                  ),
                  activeItem: Icon(
                    Icons.saved_search,
                    color: ColorModel.bottomNavigationBarBkgColor,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.settings,
                    color: ColorModel.notchColor,
                  ),
                  activeItem: Icon(
                    Icons.settings,
                    color: ColorModel.bottomNavigationBarBkgColor,
                  ),
                  itemLabel: 'Page 3',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                debugPrint('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorModel.pageBkgColor,
        child: const Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorModel.pageBkgColor,
        child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorModel.pageBkgColor,
        child: const Center(child: Text('Page 3')));
  }
}

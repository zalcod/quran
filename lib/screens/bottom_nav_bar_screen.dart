import 'dart:io';

import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/providers/home_provider.dart';
import 'package:fabrikod_quran/providers/more_provider.dart';
import 'package:fabrikod_quran/providers/player_provider.dart';
import 'package:fabrikod_quran/screens/bookmark_screen.dart';
import 'package:fabrikod_quran/screens/home_screen.dart';
import 'package:fabrikod_quran/screens/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PlayerProvider>().createAudioHandler(context);
  }

  /// Current index of bottom navigation bar
  int currentIndex = 0;

  /// Changes index of bottom navigation Bar
  changeIndex(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider(context)),
        ChangeNotifierProvider(create: (_) => MoreProvider(context)),
      ],
      child: Scaffold(
        body: buildBody,
        bottomNavigationBar: buildBottomNavigationBar,
      ),
    );
  }

  /// Stack pages of the [BottomNavigationBar]
  Widget get buildBody {
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomeScreen(),
        BookmarkScreen(),
        MoreScreen(),
      ],
    );
  }

  Widget get buildBottomNavigationBar {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: changeIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          buildBottomNavigationBarItem(
            icon: ImageConstants.homeInactiveIcon,
            activeIcon: ImageConstants.homeActiveIcon,
          ),
          buildBottomNavigationBarItem(
            icon: ImageConstants.bookmarkInactiveIcon,
            activeIcon: ImageConstants.bookmarkActiveIcon,
          ),
          buildBottomNavigationBarItem(
            icon: ImageConstants.moreInactiveIcon,
            activeIcon: ImageConstants.moreActiveIcon,
          )
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String icon,
    required String activeIcon,
  }) {
    double padding = Platform.isIOS ? kPaddingDefault : 0;
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: padding),
        child: SvgPicture.asset(
          icon,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(top: padding),
        child: SvgPicture.asset(
          activeIcon,
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        ),
      ),
      label: "",
    );
  }
}

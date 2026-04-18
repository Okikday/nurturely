import 'dart:developer';
import 'dart:math' as math;

import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/ai_chat/gemini_chat_screen.dart';
import 'package:techstars_hackathon/views/overview/pages/community_screen.dart';
import 'package:techstars_hackathon/views/overview/pages/home_screen.dart';
import 'package:techstars_hackathon/views/overview/pages/savings_box.dart';
import 'package:techstars_hackathon/views/overview/pages/settings_screen.dart';
import 'package:techstars_hackathon/views/overview/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Map<String, dynamic>> navBarItems = [
    {"selected": false, "iconCopy": Iconsax.home_1_copy, "icon": Iconsax.home_1},
    {"selected": false, "iconCopy": Iconsax.wallet_1_copy, "icon": Iconsax.wallet_1_copy},
    {"selected": false, "iconCopy": Iconsax.people_copy, "icon": Iconsax.people},
    {"selected": false, "iconCopy": Iconsax.setting_copy, "icon": Iconsax.setting},
  ];
  final List<Widget> pages = [HomeScreen(), SavingsBox(), CommunityScreen(), SettingsScreen()];
  final Widget geminiChatScreen = const GeminiChatScreen();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
    final ThemeData themeData = Theme.of(context);
    final double width = mediaQuery.size.width;

    return PopScope(
      canPop: false,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: themeData.scaffoldBackgroundColor,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavBar(
            selectedIndex: selectedIndex,
            navBarItems: navBarItems,
            primaryColorDark: themeData.primaryColorDark,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
              _pageController.animateToPage(selectedIndex, duration: Durations.extralong1, curve: CustomCurves.defaultIosSpring);
            },
            scaffoldBackgroundColor: themeData.scaffoldBackgroundColor,
          ),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            controller: _pageController,
            children: pages,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}



import 'dart:ui';

import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/themes.dart';
import 'package:techstars_hackathon/views/ai_chat/gemini_chat_screen.dart';
import 'package:techstars_hackathon/views/onboarding/welcome_screen.dart';
import 'package:techstars_hackathon/views/overview/pages/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        home: Scaffold(body: SplashScreen()));
  }
}








class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.extralong4, () {
      if (mounted) {
        context.pushReplacementTransition(type: PageTransitionType.fade, child: const WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg_1.jpg"), fit: BoxFit.cover, opacity: 0.1)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Center(child: CustomText("TechStars ", fontSize: 64, color: Colors.lightBlue)),
      ),
    );
  }
}

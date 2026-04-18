import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/onboarding/onboarding_1.dart';
import 'package:techstars_hackathon/views/onboarding/who_are_you.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: isDarkMode ? themeData.scaffoldBackgroundColor : TechStarsColors.lighterTeal,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(

            gradient: isDarkMode ? null : LinearGradient(
              colors: [TechStarsColors.lighterTeal, themeData.scaffoldBackgroundColor],
              stops: [0.1, 0.2],
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Center(child: Image.asset("assets/images/three_teal_dots.png", height: 24)),

                  const SizedBox(height: 48),

                  SizedBox(width: width, child: CustomText("Welcome to", fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(width: width, child: CustomText("Nurturely", fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold,
                    shadows: [
                    BoxShadow(color: Colors.yellow, spreadRadius: 5, offset: Offset.zero)
                  ],)),

                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: SvgPicture.asset("assets/svgs/nurturely_logo.svg", width: width * 0.65, height: width * 0.65, ),
                          ),
                        ),
                        CustomText(
                          "Nurturing you and your little one with expert care, guidance, and community...",
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(themeData.primaryColorDark)),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.rightToLeftWithFade,
                              child: Onboarding1(),
                              duration: Durations.extralong1,
                              curve: CustomCurves.defaultIosSpring,
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

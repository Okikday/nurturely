import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/onboarding/who_are_you.dart';
import 'package:techstars_hackathon/views/overview/main_screen.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 24,),
              CustomText("Chat with our AI model for assistance", fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold,),

              Expanded(child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(
                    color: TechStarsColors.altLightGray,
                    blurRadius: 30
                  )]
                ),
                  child: SvgPicture.asset("assets/svgs/filled_ai_sparkle.svg", width: width * 0.6, height: width * 0.6,))),

              CustomText("Chat with our smart Assistant to get quick and personalized assistance."),

              const SizedBox(height: 32,),


              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomElevatedButton(
                    label: "Continue",
                    textSize: 16,
                    textColor: Colors.white,
                    pixelHeight: 48,
                    backgroundColor: themeData.primaryColorDark,
                    onClick: () {
                      context.pushTransition(
                        type: PageTransitionType.fade,
                        child: MainScreen(),
                        duration: Durations.extralong1,
                        curve: CustomCurves.defaultIosSpring,
                      );
                      // HiveData().setData(key: "userType", value: selectedIndex);
                      // context.pushTransition(
                      //   type: PageTransitionType.rightToLeftWithFade,
                      //   child: HowMuchInfo(defaultText: AppValues.userTypeHowMuch[selectedIndex],),
                      //   duration: Durations.extralong1,
                      //   curve: CustomCurves.defaultIosSpring,
                      // );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

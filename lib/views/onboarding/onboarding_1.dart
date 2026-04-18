import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/onboarding/onboarding_2.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;


    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: themeData.scaffoldBackgroundColor,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight + 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16 ),
                  child: CustomText("Save ahead of your baby's delivery", fontSize: 24, color: Colors.black, fontWeight: FontWeight.w600,)),

              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(color: TechStarsColors.primary, thickness: 6,),
                      Image.asset("assets/images/save_money.png"),
                      Divider(color: TechStarsColors.primary, thickness: 6,),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16 ),
                child: CustomText("Secure your future with our Safebox. plan and save effortlessly for your baby’s delivery.", color: Colors.black, fontSize: 16,),
              ),

              const SizedBox(height: 32,),

              Padding(
                padding: const EdgeInsets.only(bottom: 32, right: 24),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(12),
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(themeData.primaryColorDark)),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: Onboarding2(),
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
    );
  }
}

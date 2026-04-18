import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/onboarding/onboarding_3.dart';
import 'package:techstars_hackathon/views/overview/pages/home_screen.dart';
import 'package:techstars_hackathon/views/overview/main_screen.dart';

class HowMuchInfo extends StatelessWidget {
  final String defaultText;
  const HowMuchInfo({super.key, required this.defaultText});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    final double width = mediaQuery.size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: themeData.scaffoldBackgroundColor,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),

              CustomText("Knowing you..", fontSize: 14, fontWeight: FontWeight.w600, color: TechStarsColors.primary,),

              const SizedBox(height: 48),

              SizedBox(width: width * 0.8, child: CustomText(defaultText, fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black,)),

              const SizedBox(height: 48),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Iconsax.minus_cirlce, size: 64, color: themeData.primaryColorDark)),
                        const SizedBox(width: 12),
                        CustomTextfield(
                          pixelWidth: 120,
                          pixelHeight: 120,
                          defaultText: "0",
                          internalArgs: (c, f) => c.text = RegExp(r'^\d{1,2}').stringMatch(c.text) ?? '',
                          inputContentPadding: EdgeInsets.all(20),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputTextStyle: TextStyle(fontSize: 50, fontWeight: FontWeight.w600, color: Colors.black),
                          backgroundColor: TechStarsColors.lighterTeal,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: TechStarsColors.altLightGray),
                          ),
                          cursorColor: TechStarsColors.primary,
                          selectionColor: TechStarsColors.primary.withAlpha(100),
                          selectionHandleColor: TechStarsColors.primary,

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide(color: TechStarsColors.lightTeal),
                          ),
                        ),
                        const SizedBox(width: 12),
                        IconButton(onPressed: () {}, icon: Icon(Iconsax.add_circle, size: 64, color: themeData.primaryColorDark)),
                      ],
                    ),

                     SizedBox(height: mediaQuery.viewInsets.bottom < 20 ? 48 : 24,),

                    GestureDetector(
                      onTap: (){
                        CustomSnackBar.showSnackBar(context, content: "Disabled", vibe: SnackBarVibe.info);
                      },
                      child: Container(
                        height: 56,
                        width: 288,
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: TechStarsColors.lighterTeal,
                          border: Border.fromBorderSide(BorderSide(color: TechStarsColors.altLightGray)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(36),
                            topRight: Radius.circular(36),
                            bottomLeft: Radius.circular(36),
                          ),
                        ),
                        child: Row(
                          spacing: 12,
                          children: [
                            Icon(Iconsax.calendar_edit_copy, color: TechStarsColors.darkBlue,),
                            Expanded(child: CustomText("Week(s)", color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600,)),

                            Icon(Iconsax.arrow_down_1_copy, color: TechStarsColors.darkBlue)

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomElevatedButton(
                    textColor: Colors.white,
                    label: "Continue",
                    textSize: 16,
                    pixelHeight: 48,
                    backgroundColor: themeData.primaryColorDark,
                    onClick: () {

                      context.pushReplacementTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: Onboarding3(),
                        duration: Durations.extralong1,
                        curve: CustomCurves.defaultIosSpring,
                      );
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

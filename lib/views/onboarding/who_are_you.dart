import 'dart:developer';

import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/app_values.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/core/data/hive_data.dart';
import 'package:techstars_hackathon/views/onboarding/how_much_info.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({super.key});

  @override
  State<WhoAreYou> createState() => _WhoAreYouState();
}

class _WhoAreYouState extends State<WhoAreYou> {
  int selectedIndex = 1;
  final options = AppValues.userTypeOptions;

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: kToolbarHeight),

                  CustomText("Getting Started", fontSize: 14, fontWeight: FontWeight.w600, color: TechStarsColors.primary,),

                  const SizedBox(height: 48),

                  SizedBox(
                    width: width * 0.9,
                    child: CustomText("A Personalized experience, \nJust for you", color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 12),
                      constraints: BoxConstraints(minHeight: height < 700 ? 270 : 281, maxHeight: height < 700 ? 270 : 360,),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(BorderSide(color: TechStarsColors.altLightGray)),
                        color: TechStarsColors.lighterTeal,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 18, child: CustomText("Select an Option.", fontWeight: FontWeight.w600, color: Colors.black, )),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: List.generate(4, (index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 4.0),
                                  child: SelectAnOptionListTile(
                                    isDarkMode: isDarkMode,
                                    leadingImageAsset: options[index]["assetName"] ?? "",
                                    title: options[index]["title"] ?? "",
                                    subtitle: options[index]["subtitle"] ?? "",
                                    isSelected: selectedIndex == index,
                                    onTap: () {
                                      log("Index: $index tapped");
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: CustomText(
                          "Log in as Guest",
                          textDecoration: TextDecoration.underline,
                          decorationColor: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
                      HiveData().setData(key: "userType", value: selectedIndex);
                      context.pushTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: HowMuchInfo(defaultText: AppValues.userTypeHowMuch[selectedIndex],),
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

class SelectAnOptionListTile extends StatelessWidget {
  final String leadingImageAsset;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final Color? titleColor;
  final void Function()? onTap;
  final bool isSelected;
  final bool isDarkMode;

  const SelectAnOptionListTile({
    super.key,
    required this.leadingImageAsset,
    required this.title,
    this.onTap,
    this.subtitle,
    this.subtitleColor,
    this.titleColor,
    required this.isSelected,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Animate(
        effects: [FadeEffect()],
        child: CustomElevatedButton(
          contentPadding: EdgeInsets.zero,
          borderRadius: 0,
          overlayColor: TechStarsColors.lightTeal,
          onClick: () {},
          // Color(0xFF655A5A)
          backgroundColor:
              isSelected
                  ? TechStarsColors.primary : Color(0xFFACD3D3),
          child: ListTile(
            leading: CircleAvatar(radius: 18, backgroundImage: AssetImage(leadingImageAsset)),
            title: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomText(
                title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            subtitle:
                subtitle == null
                    ? null
                    : Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: CustomText(
                        subtitle!,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
            trailing: CircleAvatar(
              radius: 16.5,
              backgroundColor: TechStarsColors.lighterTeal,
              child: Icon(Iconsax.tick_circle, size: 32, color: isSelected ? TechStarsColors.primary : TechStarsColors.altLightGray),
            ),
            contentPadding: const EdgeInsets.only(left: 24, top: 2, bottom: 2, right: 12),
            onTap: () {
              if (onTap != null) onTap!();
            },
          ),
        ),
      ),
    );
  }
}

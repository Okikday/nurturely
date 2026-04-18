import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:techstars_hackathon/common/colors.dart';

class SavingsBox extends StatelessWidget {
  const SavingsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    final double width = mediaQuery.size.width;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          CustomText("Savings box", fontSize: 24, fontWeight: FontWeight.bold),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: 160,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: TechStarsColors.lightGray,
                    border: Border.fromBorderSide(BorderSide(color: TechStarsColors.primaryDark.withAlpha(40))),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextButton(
                            onClick: () {},
                            icon: Icon(Iconsax.eye, color: TechStarsColors.primary),
                            child: CustomText("Available balance"),
                          ),

                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: CircleAvatar(
                                  radius: 14,
                                    backgroundColor: Colors.white, child: Icon(Iconsax.setting, size: 18,)),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: CustomText("123,472.47", fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(radius: 22, backgroundColor: Colors.red, child: Icon(Icons.emergency_outlined, color: Colors.white)),

                          const SizedBox(width: 12),

                          CircleAvatar(
                            radius: 22,
                            backgroundColor: TechStarsColors.primary,
                            child: Icon(Iconsax.receive_square, color: Colors.white),
                          ),

                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

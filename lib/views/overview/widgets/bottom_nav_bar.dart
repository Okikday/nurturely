import 'dart:developer';
import 'dart:math' as math;

import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techstars_hackathon/common/colors.dart';
import 'package:techstars_hackathon/views/ai_chat/gemini_chat_screen.dart';
import 'package:techstars_hackathon/views/ai_chat/gemini_chat_view.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List navBarItems;
  final Color primaryColorDark;
  final Color scaffoldBackgroundColor;
  final void Function(int index) onTap;
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.navBarItems,
    required this.primaryColorDark,
    required this.onTap,
    required this.scaffoldBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = List.generate(navBarItems.length, (index) {
      return buildNavBarIconButton(
        selectedIndex == index,
        navBarItems[index]["iconCopy"],
        navBarItems[index]["icon"],
        selectedIndex == index ? TechStarsColors.altPrimary.withAlpha(200) : TechStarsColors.primary,
        onTap: () => onTap(index),
      );
    });

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          type: MaterialType.transparency,
          shape: LinearBorder(side: BorderSide(color: Color(0xFFD9D9D9)), top: LinearBorderEdge()),
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [children[0], children[1], SizedBox(width: 48), children[2], children[3]],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 28,
          child: Center(
            child: PartialCircleBorder(
              size: 72,
              strokeWidth: 1,
              borderColor: const Color(0xFFD9D9D9),
              fillColor: scaffoldBackgroundColor, // Add a fill color.
              startAngle: 0, // Starting at 180° (bottom)
              sweepAngle: math.pi, // Drawing a half-circle.
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 32 + 2,
          child: Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (event) {
                log("Tap down:");
              },
              onTap: () {
                Navigator.of(context).push(
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: GeminiChatScreen(),
                    // child: GeminiChatView()
                  ),
                );
              },
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [TechStarsColors.primary, TechStarsColors.lightTeal], stops: [0.75, 1.0]),
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: SizedBox.square(
                        dimension: 44,
                        child: SvgPicture.asset(
                          "assets/svgs/ai_sparkle.svg",
                          width: 40,
                          height: 40,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

buildNavBarIconButton(bool isSelected, IconData icon, IconData activeIcon, Color iconColor, {void Function()? onTap}) {
  return AnimatedSize(
    duration: Durations.short3,
    child: IconButton(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(15))),
      onPressed: () {
        if (onTap != null) onTap();
      },
      icon: Icon(isSelected ? activeIcon : icon, size: isSelected ? 36 : 32, color: iconColor),
    ),
  );
}

class PartialCircleBorder extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color borderColor;
  final Color? fillColor; // Optional fill color.
  // startAngle and sweepAngle in radians.
  final double startAngle;
  final double sweepAngle;

  const PartialCircleBorder({
    super.key,
    required this.size,
    required this.strokeWidth,
    required this.borderColor,
    this.fillColor,
    this.startAngle = math.pi, // Default: start at bottom.
    this.sweepAngle = math.pi, // Default: draw a half circle.
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PartialCirclePainter(
        strokeWidth: strokeWidth,
        borderColor: borderColor,
        fillColor: fillColor,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
      ),
    );
  }
}

class _PartialCirclePainter extends CustomPainter {
  final double strokeWidth;
  final Color borderColor;
  final Color? fillColor;
  final double startAngle;
  final double sweepAngle;

  _PartialCirclePainter({
    required this.strokeWidth,
    required this.borderColor,
    this.fillColor,
    required this.startAngle,
    required this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;

    // If a fill color is provided, fill the shape.
    if (fillColor != null) {
      final Paint fillPaint =
          Paint()
            ..color = fillColor!
            ..style = PaintingStyle.fill;
      // For a full circle, simply draw the circle.
      if (sweepAngle == 2 * math.pi) {
        canvas.drawCircle(center, radius, fillPaint);
      } else {
        // For partial arcs, this fills a pie slice.
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          true, // "useCenter" true fills the shape as a pie slice.
          fillPaint,
        );
      }
    }

    // Draw the border (stroke) for the arc.
    final Paint borderPaint =
        Paint()
          ..color = borderColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _PartialCirclePainter oldDelegate) {
    return oldDelegate.borderColor != borderColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle ||
        oldDelegate.fillColor != fillColor;
  }
}

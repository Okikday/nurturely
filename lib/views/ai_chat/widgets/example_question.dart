import 'package:custom_widgets_toolkit/custom_widgets_toolkit.dart';
import 'package:flutter/material.dart';


class ExampleQuestion extends StatelessWidget {
  /// The example question text.
  final String question;
  final void Function(String question) onTap;

  const ExampleQuestion({super.key, required this.question, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final primaryColor = theme.primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(question),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(isDarkMode ? 77 : 38),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withAlpha(isDarkMode ? 128 : 77), width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(isDarkMode ? 77 : 13), blurRadius: 8, spreadRadius: -2, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.chat_bubble_outline_rounded, size: 20, color: (isDarkMode ? Colors.white : primaryColor)),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.arrow_forward_rounded, size: 20, color: (isDarkMode ? Colors.white : primaryColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
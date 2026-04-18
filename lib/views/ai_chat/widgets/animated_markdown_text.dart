import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AnimatedMarkdownText extends StatefulWidget {
  final String markdownText;
  const AnimatedMarkdownText({super.key, required this.markdownText});

  @override
  State<AnimatedMarkdownText> createState() => _AnimatedMarkdownTextState();
}

class _AnimatedMarkdownTextState extends State<AnimatedMarkdownText> {
  String _animatedText = "";

  @override
  void initState() {
    super.initState();
    _animateText();
  }

  void _animateText() async {
    String fullText = widget.markdownText;
    for (int i = 0; i <= fullText.length; i++) {
      await Future.delayed(Duration(milliseconds: 50)); // Adjust speed here
      setState(() {
        _animatedText = fullText.substring(0, i);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: _animatedText, // Dynamically updating text
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lisait/utils.dart';

class TextDisplay extends StatelessWidget {
  final String text;
  const TextDisplay({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (9.0 * text.length) + 10,
      height: 25,
      decoration: BoxDecoration(
        color: Pallete.gray,
        border: Border.all(
          color: Pallete.red,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Text(text, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
    );
  }
}

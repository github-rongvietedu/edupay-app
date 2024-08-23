import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TextWithDot extends StatelessWidget {
  final String text;
  final TextStyle style;
  const TextWithDot({Key? key, required this.text, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Entypo.dot_single),
        Flexible(child: Text(text, maxLines: 2, style: style))
      ],
    );
  }
}

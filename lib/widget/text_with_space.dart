import 'package:flutter/material.dart';

class TextWithSpace extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle textStyle1;
  final TextStyle textStyle2;
  final int flex1;
  final int flex2;
  final double space;
  const TextWithSpace(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.space,
      required this.textStyle1,
      required this.textStyle2,
      required this.flex1,
      required this.flex2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: flex1,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: text1,
                  style: textStyle1,
                ),
              )),
          SizedBox(
            width: space,
          ),
          Expanded(
              flex: flex2,
              child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: text2,
                    style: textStyle2,
                  ))),
        ]);
  }
}

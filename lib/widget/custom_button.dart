import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? text;
  final Widget? image;
  final VoidCallback? onPressed;
  final bool? enable;
  const CustomButton(
      {this.color,
      this.textColor,
      this.text,
      this.onPressed,
      this.image,
      this.enable});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: image != null
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: enable == true ? color : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: enable == true ? onPressed : null,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: kPaddingL),
                    child: image,
                  ),
                  Text(
                    text!,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )
          : TextButton(
              style: TextButton.styleFrom(
                backgroundColor: enable == true ? color : Colors.grey,
                padding: const EdgeInsets.all(kPaddingM),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onPressed: enable == true ? onPressed : null,
              child: Text(
                text!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EdupayAppBar extends StatelessWidget {
  const EdupayAppBar({super.key, this.titleWidget, this.onBackPressed});
  final Widget? titleWidget;
  final void Function()? onBackPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50,
          ),
          child: Container(
            // color: Colors.yellow,
            width: size.width,
            child: titleWidget ?? SizedBox(),
          ),
        ),
        Positioned(
          top: 8,
          left: 16,
          child: GestureDetector(
            onTap: onBackPressed ?? () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 16,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

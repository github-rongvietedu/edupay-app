import 'package:edupay/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWithTextWidget extends StatelessWidget {
  const IconWithTextWidget(
      {super.key,
      required this.size,
      this.image = '',
      required this.text,
      this.margin,
      this.child = const SizedBox()});

  final Size size;
  final String? image;
  final Text text;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.045,
      margin: margin ?? EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                image!.isEmpty
                    ? SizedBox()
                    : Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: kPrimaryColor, width: 0.5),
                                ),
                                child: SvgPicture.asset(
                                  image!,
                                  colorFilter: ColorFilter.mode(
                                      kPrimaryColor, BlendMode.srcIn),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),

                text,
                // SizedBox(width: 10),
              ],
            ),
            child
          ]),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearGradientButton extends StatelessWidget {
  final double fontSize;
  final String text;
  final Color textColor;
  final Color color1;
  final Color color2;
  final FontWeight fontWeight;
  final double margin;
  final Color borderColor;
  final String icon;
  final double iconSize;
  final borderRadius;
  final Color iconColor;
  final double padding;
  LinearGradientButton({this.iconColor=Colors.transparent,this.padding=16,this.borderRadius=120.0,this.iconSize=0,this.icon='',this.fontSize=16,required this.text,required this.textColor,this.fontWeight=FontWeight.normal, required this.color1,required this.color2,this.margin=0,this.borderColor=Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          gradient : LinearGradient(
              begin: Alignment(1.2978894710540771,0.13568845391273499),
              end: Alignment(-0.13568845391273499,0.07066287100315094),
              colors: [color1,color2]
          ),
          border: Border.all(color: borderColor), // Add this line
        ),
        padding: EdgeInsets.only(left: padding+8,right: padding+8,top: 2*padding/3,bottom: 2*padding/3),
        margin: EdgeInsets.only(left: margin,right: margin),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              this.icon==''?SizedBox():
              Image.asset(icon,fit: BoxFit.contain,width: this.iconSize,height: this.iconSize,color: this.iconColor,),
              SizedBox(width: this.icon==''?0:8),
              Text(text, textAlign: TextAlign.center, style: TextStyle(
                  decoration: TextDecoration.none,
                  color: this.textColor,
                  fontFamily: 'Inter',
                  fontSize: fontSize,
                  letterSpacing: 0,
                  fontWeight: this.fontWeight,
                  height: 1.5 /*PERCENT not supported*/
              ))]));
  }
}

class WhiteButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final FontWeight fontWeight;
  double fontSize;
  WhiteButton({required this.text,required this.textColor,this.fontWeight=FontWeight.normal,this.fontSize=10});
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 3,bottom: 3,left: 6,right: 6),
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(120),
            topRight: Radius.circular(120),
            bottomLeft: Radius.circular(120),
            bottomRight: Radius.circular(120),
          ),
          border: Border.all(color: textColor), // Add this line
        ),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(
            decoration: TextDecoration.none,
            color: this.textColor,
            fontFamily: 'Inter',
            fontSize: fontSize,
            letterSpacing: 0,
            fontWeight: this.fontWeight,
            height: 1.5 /*PERCENT not supported*/
        )));
  }
}





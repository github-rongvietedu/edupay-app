import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFFC5282F);
const ksecondaryColor = Color(0xFFB5BFD0);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kBlack = Colors.black;
const kTextColor = Color(0xFF50505D);
const kBlueColor = Color(0xff1890FF);
const kDarkBlueColor = Color(0xff1D4CA7);
const kOrangeCode = Color(0xffF6662D);
const kBackgroundBorder = Color(0xff64748B);
const kTextLightColor = Color(0xFF6A727D);
const Color textColor = Color(0xffE8E0D2);

const kDefaultPaddin = 20.0;
TextStyle kTextStyleTable =
    GoogleFonts.robotoCondensed(fontSize: 16, fontWeight: FontWeight.bold);

TextStyle kTextStyleBold = GoogleFonts.robotoCondensed(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black.withOpacity(0.7));
TextStyle kTextStyleNomalBrown = GoogleFonts.robotoCondensed(
    fontSize: 14, color: Colors.black.withOpacity(0.7), wordSpacing: 0.5);
TextStyle kTextStyleNomal =
    GoogleFonts.robotoCondensed(fontSize: 14, wordSpacing: 0.5);
TextStyle kTextStyleNomal22 =
    GoogleFonts.robotoCondensed(fontSize: 20, wordSpacing: 0.5);
TextStyle kTextStyleBlackBold = GoogleFonts.robotoCondensed(
    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle kTextStyleTitle = GoogleFonts.ptSansNarrow(
    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue);

TextStyle kTextStyleProfile = GoogleFonts.robotoCondensed(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle kTextStyleTitleColor = GoogleFonts.robotoCondensed(
    fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor);
TextStyle kTextStyleRowBlue = GoogleFonts.robotoCondensed(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue);

/// font Inter
TextStyle textInter8 = GoogleFonts.inter()
    .copyWith(fontSize: 8, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter10 = GoogleFonts.inter()
    .copyWith(fontSize: 10, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter12 = GoogleFonts.inter()
    .copyWith(fontSize: 12, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter14 = GoogleFonts.inter()
    .copyWith(fontSize: 14, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter15 = GoogleFonts.inter()
    .copyWith(fontSize: 15, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter16 = GoogleFonts.inter()
    .copyWith(fontSize: 16, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter18 = GoogleFonts.inter()
    .copyWith(fontSize: 18, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter20 = GoogleFonts.inter()
    .copyWith(fontSize: 20, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter22 = GoogleFonts.inter()
    .copyWith(fontSize: 22, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter24 = GoogleFonts.inter()
    .copyWith(fontSize: 24, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter26 = GoogleFonts.inter()
    .copyWith(fontSize: 26, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter28 = GoogleFonts.inter()
    .copyWith(fontSize: 28, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter32 = GoogleFonts.inter()
    .copyWith(fontSize: 32, color: textColor, overflow: TextOverflow.ellipsis);
TextStyle textInter42 = GoogleFonts.inter()
    .copyWith(fontSize: 42, color: textColor, overflow: TextOverflow.ellipsis);

Color stringToColor(String colorString) {
  String hexColor = colorString.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "0xff" + hexColor; // Add the alpha value if not provided
  }
  return Color(int.parse(hexColor));
}

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
}

extension TextStyleExtColor on TextStyle {
  //Khai báo màu chữ ở đây
  TextStyle get primaryColor => this.copyWith(color: Color(0xff27442C));
  TextStyle get whiteColor => this.copyWith(color: Color(0xffFFFFFF));
  TextStyle get blackColor => this.copyWith(color: Color(0xff334155));
  TextStyle get blueColor => this.copyWith(color: Color(0xff1890FF));
  TextStyle get darkBlueColor => this.copyWith(color: kDarkBlueColor);
  TextStyle get greyColor => this.copyWith(color: Color(0xff64748B));
  TextStyle get lightColor => this.copyWith(color: Color(0xffE8E0D2));
  TextStyle get creamColor => this.copyWith(color: Color(0xffE8E0D2));
  TextStyle get greenColor => this.copyWith(color: Color(0xff0BA259));
  TextStyle get orangeAccentColor => this.copyWith(color: Color(0xffFA8C16));
  TextStyle get secondColor => this.copyWith(color: Color(0xffD5985D));
  TextStyle get redColor => this.copyWith(color: Color(0xffE1404F));
  TextStyle get redAccentColor => this.copyWith(color: Color(0xffFD6A6A));
  TextStyle get greyAccentColor => this.copyWith(color: Color(0xff64748B));
  TextStyle get disableColor =>
      this.copyWith(color: Color.fromARGB(255, 175, 175, 175));
}

// extension TextStyleExt on TextStyle {
//   //Decoration style
//   TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
// }

// extension TextStyleExtColor on TextStyle {
//   //Decoration style
//   TextStyle get primaryColor => copyWith(color: const Color(0xFFFA5F55));
//   TextStyle get whiteColor => copyWith(color: Colors.white);
//   TextStyle get blackColor => copyWith(color: Colors.black);
//   TextStyle get black54Color => copyWith(color: Colors.black54);
//   TextStyle get greyColor => copyWith(color: Colors.grey);
//   TextStyle get greenColor => copyWith(color: Colors.green);
//   TextStyle get green600Color => copyWith(color: Colors.green[600]);
//   TextStyle get blueColor => copyWith(color: Colors.blue);
//   TextStyle get creamColor => copyWith(color: const Color(0xffE8E0D2));
//   TextStyle get rveColor => copyWith(color: const Color(0xFF47a4d9));
//   TextStyle get secondColor => copyWith(color: const Color(0xffD5985D));
//   TextStyle get amberAccent => copyWith(color: Colors.amberAccent);
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kPrimaryColor = Color(0xFFC5282F);
const ksecondaryColor = Color(0xFFB5BFD0);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kBlack = Colors.black;
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

const kDefaultPaddin = 20.0;
TextStyle kTextStyleTable =
    GoogleFonts.robotoCondensed(fontSize: 18, fontWeight: FontWeight.bold);

TextStyle kTextStyleBold = GoogleFonts.robotoCondensed(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black.withOpacity(0.7));
TextStyle kTextStyleNomalBrown = GoogleFonts.robotoCondensed(
    fontSize: 18, color: Colors.black.withOpacity(0.7), wordSpacing: 0.5);
TextStyle kTextStyleNomal =
    GoogleFonts.robotoCondensed(fontSize: 18, wordSpacing: 0.5);
TextStyle kTextStyleNomal22 =
    GoogleFonts.robotoCondensed(fontSize: 20, wordSpacing: 0.5);
TextStyle kTextStyleBlackBold = GoogleFonts.robotoCondensed(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle kTextStyleTitle = GoogleFonts.ptSansNarrow(
    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blue);

TextStyle kTextStyleProfile = GoogleFonts.robotoCondensed(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle kTextStyleTitleColor = GoogleFonts.robotoCondensed(
    fontSize: 20, fontWeight: FontWeight.bold, color: kPrimaryColor);
TextStyle kTextStyleRowBlue = GoogleFonts.robotoCondensed(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue);

TextStyle text12 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 12,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);
TextStyle text14 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 14,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);
TextStyle text16 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 16,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);
TextStyle text18 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 18,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);
TextStyle text20 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 20,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);
TextStyle text22 = GoogleFonts.robotoCondensed().copyWith(
    fontSize: 22,
    color: kBlack,
    wordSpacing: 0.5,
    overflow: TextOverflow.ellipsis);

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);
}

extension TextStyleExtColor on TextStyle {
  //Decoration style
  TextStyle get primaryColor => copyWith(color: const Color(0xFFFA5F55));
  TextStyle get whiteColor => copyWith(color: Colors.white);
  TextStyle get blackColor => copyWith(color: Colors.black);
  TextStyle get black54Color => copyWith(color: Colors.black54);
  TextStyle get greyColor => copyWith(color: Colors.grey);
  TextStyle get greenColor => copyWith(color: Colors.green);
  TextStyle get green600Color => copyWith(color: Colors.green[600]);
  TextStyle get blueColor => copyWith(color: Colors.blue);
  TextStyle get creamColor => copyWith(color: const Color(0xffE8E0D2));
  TextStyle get rveColor => copyWith(color: const Color(0xFF47a4d9));
  TextStyle get secondColor => copyWith(color: const Color(0xffD5985D));
  TextStyle get amberAccent => copyWith(color: Colors.amberAccent);
}

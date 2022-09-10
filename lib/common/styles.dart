import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xff354038);
const Color primaryRed = Color(0xffB51717);
const Color secondaryRed = Color(0xffEC4444);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.inter(
      fontSize: 92, fontWeight: FontWeight.w700),
  headline2: GoogleFonts.inter(
      fontSize: 57, fontWeight: FontWeight.w700),
  headline3: GoogleFonts.inter(
      fontSize: 46, fontWeight: FontWeight.w700),
  headline4: GoogleFonts.inter(
      fontSize: 32, fontWeight: FontWeight.w700),
  headline5: GoogleFonts.inter(
      fontSize: 23, fontWeight: FontWeight.w600),
  headline6: GoogleFonts.inter(
      fontSize: 19, fontWeight: FontWeight.w500),
  subtitle1: GoogleFonts.inter(
      fontSize: 15, fontWeight: FontWeight.w400),
  subtitle2: GoogleFonts.inter(
      fontSize: 13, fontWeight: FontWeight.w500),
  bodyText1: GoogleFonts.inter(
      fontSize: 16, fontWeight: FontWeight.w400),
  bodyText2: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w400),
  button: GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w500),
  caption: GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w400),
  overline: GoogleFonts.inter(
      fontSize: 10, fontWeight: FontWeight.w400),
);
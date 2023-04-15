// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

const Tiny = 13.0;
const Small = 14.0;
const Medium = 16.0;
const Large = 24.0;
const Bold = 25.0;
const VeryBold = 45.0;
const String font = "Gilroy";

TextStyle smallText(Color colors) => TextStyle(
      color: colors,
      fontSize: Small,
      height: 1.5,
      fontFamily: font,
      fontWeight: FontWeight.w600,
    );

TextStyle tiny() => TextStyle(
      fontSize: Tiny,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w200,
    );

TextStyle small() => TextStyle(
      fontSize: Small,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w600,
    );

TextStyle smallBold(Color colors) => TextStyle(
      color: colors,
      fontSize: Small,
      height: 1.5,
      fontFamily: font,
      fontWeight: FontWeight.w600,
    );

TextStyle mediumText(Color colors) => TextStyle(
      color: colors,
      fontSize: Medium,
      height: 1.5,
      fontFamily: font,
      fontWeight: FontWeight.w600,
    );

TextStyle medium() => TextStyle(
      fontSize: Medium,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w600,
    );

TextStyle mediumBold(Color colors) => TextStyle(
      color: colors,
      fontSize: Medium,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w700,
    );

TextStyle largeText(Color colors) => TextStyle(
      color: colors,
      fontSize: Large,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w600,
    );

TextStyle large() => TextStyle(
      fontSize: Large,
      fontFamily: font,
      height: 1.5,
      fontWeight: FontWeight.w600,
    );

TextStyle boldText(Color colors) => TextStyle(
      color: colors,
      fontSize: Bold,
      fontFamily: font,
      fontWeight: FontWeight.w500,
    );

TextStyle bold() => TextStyle(
      fontSize: Bold,
      fontFamily: font,
      fontWeight: FontWeight.w700,
    );

TextStyle veryBold() => TextStyle(
      fontSize: VeryBold,
      fontFamily: font,
      fontWeight: FontWeight.w500,
    );

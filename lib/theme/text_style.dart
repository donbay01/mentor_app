// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';

const Tiny = 13.0;
const Small = 14.0;
const Medium = 16.0;
const Large = 24.0;
const Bold = 25.0;
const VeryBold = 45.0;
const String fontRoboto = "Roboto";

TextStyle smallText(Color colors) => TextStyle(
  color: colors,
  fontSize: Small,
  height: 1.5,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w300,
);

TextStyle tiny() => TextStyle(
  fontSize: Tiny,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w200,
);

TextStyle small() => TextStyle(
  fontSize: Small,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w300,
);

TextStyle smallBold(Color colors) => TextStyle(
  color: colors,
  fontSize: Small,
  height: 1.5,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w500,
);

TextStyle mediumText(Color colors) => TextStyle(
  color: colors,
  fontSize: Medium,
  height: 1.5,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w400,
);

TextStyle medium() => TextStyle(
  fontSize: Medium,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

TextStyle mediumBold(Color colors) => TextStyle(
  color: colors,
  fontSize: Medium,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

TextStyle largeText(Color colors) => TextStyle(
  color: colors,
  fontSize: Large,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

TextStyle large() => TextStyle(
  fontSize: Large,
  fontFamily: fontRoboto,
  height: 1.5,
  fontWeight: FontWeight.w500,
);

TextStyle boldText(Color colors) => TextStyle(
  color: colors,
  fontSize: Bold,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w600,
);

TextStyle bold() => TextStyle(
  fontSize: Bold,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w600,
);

TextStyle veryBold() => TextStyle(
  fontSize: VeryBold,
  fontFamily: fontRoboto,
  fontWeight: FontWeight.w600,
);

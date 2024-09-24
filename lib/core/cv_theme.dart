import 'package:flutter/material.dart';

class CvTheme {
  static const Color primaryColor = Color(0xff181C14);
  static const Color secondaryColor = Color(0xff3C3D37);
  static const Color tertiaryColor = Color(0xff697565);
  static const Color brightColor = Color(0xffECDFCC);

  static TextStyle h1 = const TextStyle(
    fontFamily: 'MaximaNouvaExtraBold',
    color: brightColor,
    fontSize: 76.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h2 = const TextStyle(
    fontFamily: 'MaximaNouvaBold',
    color: brightColor,
    fontSize: 76.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle h3 = const TextStyle(
    fontFamily: 'MaximaNouvaThin',
    color: brightColor,
    fontSize: 76.0,
    fontWeight: FontWeight.normal,
  );
}

import 'package:flutter/material.dart';

class Styles {
  static TextStyle title() {
    return TextStyle(fontSize: 24, color: orangeAccent());
  }

  static TextStyle subtitle() {
    return TextStyle(fontSize: 20, color: orange());
  }

  static TextStyle errorTitle() {
    return TextStyle(fontSize: 24, color: Colors.red[300]);
  }

  static TextStyle darkHeader() {
    return TextStyle(fontSize: 24, color: Styles.grey());
  }

  static TextStyle body() {
    return TextStyle(fontSize: 16);
  }

  static TextStyle note() {
    return TextStyle(fontSize: 20);
  }

  static MaterialColor orange() {
    Map<int, Color> colourCodes = {
      50: Color.fromRGBO(245, 179, 66, .1),
      100: Color.fromRGBO(245, 179, 66, .2),
      200: Color.fromRGBO(245, 179, 66, .3),
      300: Color.fromRGBO(245, 179, 66, .4),
      400: Color.fromRGBO(245, 179, 66, .5),
      500: Color.fromRGBO(245, 179, 66, .6),
      600: Color.fromRGBO(245, 179, 66, .7),
      700: Color.fromRGBO(245, 179, 66, .8),
      800: Color.fromRGBO(245, 179, 66, .9),
      900: Color.fromRGBO(245, 179, 66, 1),
    };

    return MaterialColor(0xfff5b342, colourCodes);
  }

  static MaterialColor orangeAccent() {
    Map<int, Color> colourCodes = {
      50: Color.fromRGBO(255, 196, 94, .1),
      100: Color.fromRGBO(255, 196, 94, .2),
      200: Color.fromRGBO(255, 196, 94, .3),
      300: Color.fromRGBO(255, 196, 94, .4),
      400: Color.fromRGBO(255, 196, 94, .5),
      500: Color.fromRGBO(255, 196, 94, .6),
      600: Color.fromRGBO(255, 196, 94, .7),
      700: Color.fromRGBO(255, 196, 94, .8),
      800: Color.fromRGBO(255, 196, 94, .9),
      900: Color.fromRGBO(255, 196, 94, 1),
    };

    return MaterialColor(0xffffc45e, colourCodes);
  }

  static MaterialColor grey() {
    Map<int, Color> colourCodes = {
      50: Color.fromRGBO(66, 66, 66, .1),
      100: Color.fromRGBO(66, 66, 66, .2),
      200: Color.fromRGBO(66, 66, 66, .3),
      300: Color.fromRGBO(66, 66, 66, .4),
      400: Color.fromRGBO(66, 66, 66, .5),
      500: Color.fromRGBO(66, 66, 66, .6),
      600: Color.fromRGBO(66, 66, 66, .7),
      700: Color.fromRGBO(66, 66, 66, .8),
      800: Color.fromRGBO(66, 66, 66, .9),
      900: Color.fromRGBO(66, 66, 66, 1),
    };

    return MaterialColor(0xff424242, colourCodes);
  }
}

import 'package:flutter/material.dart';

class Styles {
  static TextStyle title() {
    return TextStyle(fontSize: 24, color: Colors.orangeAccent);
  }

  static TextStyle errorTitle() {
    return TextStyle(fontSize: 24, color: Colors.red[300]);
  }

  static TextStyle darkHeader() {
    return TextStyle(fontSize: 24, color: Colors.grey[800]);
  }

  static TextStyle body() {
    return TextStyle(fontSize: 16);
  }

  static TextStyle note() {
    return TextStyle(fontSize: 20);
  }

  static MaterialColor orange() {
    Map<int, Color> colourCodes = {
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
}

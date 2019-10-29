import 'package:flutter/cupertino.dart';

class HexColor extends Color {

  HexColor(final String hexColorString) : super(_getColorFromHex(hexColorString));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

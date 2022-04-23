import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorAppBar with ChangeNotifier {
  Color colorAppbar = Colors.white;

  getColorFromImg(String imageProvider) async {
    try {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(NetworkImage(imageProvider));
      colorAppbar = paletteGenerator.dominantColor!.color;
      notifyListeners();
    } catch (error) {
      log(error.toString());
    }
  }
}

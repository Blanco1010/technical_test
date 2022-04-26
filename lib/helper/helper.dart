import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'dart:ui' as ui;
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<ui.Image> resizeAndConvertImage(
  String url,
  int width,
) async {
  final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
  final Uint8List markerImageBytes = markerImageFile.readAsBytesSync();
  final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
    markerImageBytes,
    targetWidth: width,
  );

  final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
  return frameInfo.image;
}

Future<BitmapDescriptor> paintToCanvas(ui.Image image, Size size) async {
  final pictureRecorder = ui.PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final paint = Paint();
  paint.isAntiAlias = true;

  _performCircleCrop(image, size, canvas);

  final recordedPicture = pictureRecorder.endRecording();
  ui.Image img = await recordedPicture.toImage(image.width, image.height);
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(buffer);
}

_performCircleCrop(ui.Image image, Size size, Canvas canvas) {
  Paint paint = Paint();
  canvas.drawCircle(const Offset(0, 0), 0, paint);

  double drawImageWidth = 0;
  double drawImageHeight = 0;

  Path path = Path()
    ..addOval(Rect.fromLTWH(drawImageWidth, drawImageHeight,
        image.width.toDouble(), image.height.toDouble()));

  canvas.clipPath(path);
  canvas.drawImage(image, Offset(drawImageWidth, drawImageHeight), Paint());
}

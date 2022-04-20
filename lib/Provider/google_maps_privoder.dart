import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps/Screen/restaurant_detail_screen.dart';

import 'package:google_maps/models/response_branch_offices_by_id_model.dart';
import 'package:google_maps/models/response_branch_offices_by_latlng_model.dart';

class GoogleMapsController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  final String _url = 'us-central1-adomi-dev.cloudfunctions.net';

  final String _token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOnsidXNlcl9pZCI6IjI5Nzk4NGIzLTQ1NDMtNDhmMC1hMTkxLTdlN2UwMWVjMWRjOCIsInVzZXJfdHlwZSI6IkFETUlOIiwicHVzaGVyX2NoYW5uZWwiOiJBRE1JTl8yOTc5ODRiMy00NTQzLTQ4ZjAtYTE5MS03ZTdlMDFlYzFkYzgifSwiaWF0IjoxNjQ0ODU5MjE3LCJleHAiOjE2NTQwNTk1OTl9.3ximsrIe4RlcXBDrVpoj7XlvhIJsLVpXEPXA42x6YeI';

  final String _cityId = 'c1e4bcc9-eb84-4653-872c-e38f8de4bf79';

  final LatLng _pos = const LatLng(4.545367057195659, -76.09435558319092);

  final bool _coverageRadio = true;

  late BuildContext context;

  Map<MarkerId, Marker> get markers => _markers;

  init(BuildContext context) async {
    this.context = context;

    final Marker marker = Marker(
      markerId: const MarkerId('user_location'),
      position: _pos,
      icon: BitmapDescriptor.fromBytes(
        await getBytesFromAsset('assets/person_location.png', 50),
      ),
    );

    _markers[const MarkerId('user_location')] = marker;
    notifyListeners();
  }

  Future getAllBranchOfficesByLatLng(LatLng latLng) async {
    try {
      final queryParameters = {
        'city_id': _cityId,
        'lat': '${latLng.latitude}',
        'lng': '${latLng.longitude}',
        'coverage_radio': '$_coverageRadio',
      };

      final Uri url = Uri.http(
        _url,
        'core/api/v1/branch-offices',
        queryParameters,
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': _token,
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final ResponseBranchOffices response =
            ResponseBranchOffices.fromJson(res.body);

        for (var item in response.data) {
          ui.Image img = await resizeAndConvertImage(item.brand.logo, 60);

          final branchOffices = await getAllBranchOfficesById(
            item.id,
            LatLng(
              item.latitude,
              item.latitude,
            ),
          );

          final Marker marker = Marker(
            infoWindow: InfoWindow(
              title: item.brand.name,
              snippet: item.brand.description,
              onTap: () async {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return RestaurantDetailScreen(
                        branchOffices: branchOffices,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final curvedAnimation = CurvedAnimation(
                          parent: animation, curve: Curves.easeInOut);

                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0)
                            .animate(curvedAnimation),
                        child: FadeTransition(
                          opacity: Tween<double>(begin: 0, end: 1)
                              .animate(curvedAnimation),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            markerId: MarkerId(item.id),
            position: LatLng(item.latitude, item.longitude),
            icon: await paintToCanvas(img, Size.zero),
          );

          _markers[MarkerId(item.id)] = marker;
        }
      }
    } catch (error) {
      log(error.toString());
    }
  }

  Future<ResponseBranchOfficesById> getAllBranchOfficesById(
      String id, LatLng latLng) async {
    try {
      final queryParameters = {
        'slim': 'false',
        'schedule': 'false',
        'lat': '${latLng.latitude}',
        'lng': '${latLng.longitude}',
        'city_id': _cityId,
      };

      final Uri url = Uri.http(
        _url,
        'core/api/v1/branch-offices/$id',
        queryParameters,
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': _token,
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        return ResponseBranchOfficesById.fromJson(res.body);
      } else {
        return ResponseBranchOfficesById(
          message: 'Error',
          code: 401,
          errors: [],
        );
      }
    } catch (error) {
      log(error.toString());
      return ResponseBranchOfficesById(
        message: 'Error',
        code: 401,
        errors: [],
      );
    }
  }
}

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

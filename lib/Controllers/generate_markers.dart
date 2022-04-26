import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Screen/restaurant_detail_screen.dart';
import '../helper/helper.dart';
import 'dart:ui' as ui;

import '../models/response_branch_offices_by_latlng_model.dart';

class GenerateMarkerButton {
  final BuildContext context;
  final ResponseBranchOffices responseBranchOffices;

  GenerateMarkerButton(this.context, this.responseBranchOffices);

  Future<Map<MarkerId, Marker>> generate() async {
    final Map<MarkerId, Marker> _markers = {};

    for (var item in responseBranchOffices.data) {
      ui.Image img = await resizeAndConvertImage(
        item.brand.logo,
        (MediaQuery.of(context).size.width * 0.25).toInt(),
      );

      final Marker _marker = Marker(
        infoWindow: InfoWindow(
          title: item.brand.name,
          snippet: item.brand.description,
          onTap: () async {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return RestaurantDetailScreen(
                    id: item.id,
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final curvedAnimation = CurvedAnimation(
                      parent: animation, curve: Curves.easeInOut);

                  return FadeTransition(
                    opacity:
                        Tween(begin: 0.0, end: 1.0).animate(curvedAnimation),
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
      _markers[MarkerId(item.id)] = _marker;
    }
    return _markers;
  }
}

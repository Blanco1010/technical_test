import 'package:google_maps/api/environment.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps/models/response_branch_offices_by_id_model.dart';
import 'package:google_maps/models/response_branch_offices_by_latlng_model.dart';

class ApiAdomiProvider {
  Future getAllBranchOfficesByLatLng(LatLng latLng) async {
    try {
      final queryParameters = {
        'city_id': Environment.cityId,
        'lat': '${latLng.latitude}',
        'lng': '${latLng.longitude}',
        'coverage_radio': Environment.coverageRadio.toString(),
      };

      final Uri url = Uri.http(
        Environment.url,
        'core/api/v1/branch-offices',
        queryParameters,
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': Environment.token,
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 200) {
        final ResponseBranchOffices response =
            ResponseBranchOffices.fromJson(res.body);

        return response;
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
        'city_id': Environment.cityId,
      };

      final Uri url = Uri.http(
        Environment.url,
        'core/api/v1/branch-offices/$id',
        queryParameters,
      );

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': Environment.token,
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 200) {
        ResponseBranchOfficesById response =
            ResponseBranchOfficesById.fromJson(res.body);

        return response;
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

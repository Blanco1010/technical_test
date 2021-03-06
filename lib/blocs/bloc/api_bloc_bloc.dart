import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/models/response_branch_offices_by_latlng_model.dart';
import 'package:google_maps/provider/google_maps_privoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../api/environment.dart';
import '../../controllers/generate_markers.dart';
import '../../helper/helper.dart';
import '../../models/response_branch_offices_by_id_model.dart';

part 'api_bloc_event.dart';
part 'api_bloc_state.dart';

class ApiBloc extends Bloc<ApiBlocEvent, ApiBlocState> {
  StreamSubscription<Position>? positionStream;
  final apiAdomi = ApiAdomiProvider();

  ApiBloc() : super(ApiBlocState()) {
    on<OnAddLocationEvent>((event, emit) =>
        emit(state.copyWith(location: event.latLng, markers: event.markers)));

    on<OnNewUserLocationEvent>(
        (event, emit) => emit(state.copyWith(location: event.newUserLatLng)));

    on<OnLoadingByLatLngEvent>(
      (event, emit) {
        Map<MarkerId, Marker> _markers = event.markers;

        Marker _mark = state.markers![const MarkerId('user_location')]!;
        _markers[const MarkerId('user_location')] = _mark;
        emit(state.copyWith(
          markers: _markers,
        ));
      },
    );

    on<OnLoadingById>(
      (event, emit) => state.copyWith(
        branchOffices: event.branchOffices,
      ),
    );
  }

  void init(BuildContext context) async {
    const LatLng _pos = LatLng(4.545367057195659, -76.09435558319092);

    final Marker marker = Marker(
      markerId: const MarkerId('user_location'),
      position: Environment.pos,
      icon: BitmapDescriptor.fromBytes(
        await getBytesFromAsset(
          'assets/person_location.png',
          (MediaQuery.of(context).size.width * 0.3).toInt(),
        ),
      ),
    );

    Map<MarkerId, Marker>? _markers = {};
    _markers[const MarkerId('user_location')] = marker;

    _markers.addAll(state.markers!);

    add(OnAddLocationEvent(_pos, _markers));
  }

  void getAllBranchOfficesByLatLng(BuildContext context) async {
    final ResponseBranchOffices response =
        await apiAdomi.getAllBranchOfficesByLatLng(state.location!);

    final _generate = GenerateMarkerButton(context, response);
    final _markes = await _generate.generate();
    add(OnLoadingByLatLngEvent(_markes));
  }

  Future<ResponseBranchOfficesById>? getAllBranchOfficesByBy(String id) async {
    final ResponseBranchOfficesById response =
        await apiAdomi.getAllBranchOfficesById(id, state.location!);

    if (state.branchOffices[id] == null) {
      state.branchOffices[id] = response;
      add(OnLoadingById(state.branchOffices));
    }
    return response;
  }
}

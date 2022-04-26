import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps/blocs/bloc/api_bloc_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Widgets/widgets.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapsScreen> createState() => GoogleMapsScreenState();
}

class GoogleMapsScreenState extends State<GoogleMapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  late ApiBloc apiBloc;

  final CameraPosition _positionCenter = const CameraPosition(
    target: LatLng(4.545367057195659, -76.09435558319092),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ApiBloc, ApiBlocState>(
          builder: ((context, state) {
            if (state.location != null) {
              return GoogleMap(
                markers: Set<Marker>.of(state.markers.values),
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _positionCenter,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            } else {
              return const Center(child: Text('CARGANDO'));
            }
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            apiBloc = BlocProvider.of<ApiBloc>(context);
            apiBloc.start();
          },
          child: const Icon(
            Icons.location_on_sharp,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 227, 214, 92),
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ButtonWidget(
                      size: MediaQuery.of(context).size.width * 0.20,
                      name: 'Buscar',
                      icon: const Icon(Icons.search),
                      function: () {
                        print('Buscar');
                        apiBloc.getAllBranchOfficesByLatLng(context);
                      },
                    ),
                    ButtonWidget(
                      size: MediaQuery.of(context).size.width * 0.20,
                      name: 'Menú',
                      icon: const Icon(Icons.menu),
                      function: () {
                        print('Menú');
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ButtonWidget(
                      size: MediaQuery.of(context).size.width * 0.20,
                      name: 'Perfil',
                      icon: const Icon(Icons.person),
                      function: () {
                        print('Perfil');
                      },
                    ),
                    ButtonWidget(
                      size: MediaQuery.of(context).size.width * 0.20,
                      name: 'Más',
                      icon: const Icon(Icons.more),
                      function: () {
                        print('Más');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_positionCenter));
  }
}

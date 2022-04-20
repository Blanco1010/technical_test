import 'package:flutter/material.dart';
import 'package:google_maps/Provider/google_maps_privoder.dart';
import 'package:google_maps/Screen/google_map_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleMapsController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GoogleMapsScreen(),
      ),
    );
  }
}

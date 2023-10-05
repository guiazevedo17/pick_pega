import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/restaurants_controller.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantsController>(
          create: (context) => RestaurantsController(),
          child: Builder(builder: (context) {
            final location = context.watch<RestaurantsController>();

            if (location.lat == 0.0 && location.long == 0.0) {
              return const Center(child: CircularProgressIndicator());
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(location.lat, location.long),
                zoom: 18,
              ),
              myLocationButtonEnabled: true,
            );
          })),
    );
  }
}
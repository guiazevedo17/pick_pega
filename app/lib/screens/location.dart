import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/restaurants_controller.dart';
import '../styles/color.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map using User Location 
          ChangeNotifierProvider<RestaurantsController>(
            create: (context) => RestaurantsController(),
            child: Builder(
              builder: (context) {
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
              },
            ),
          ),

          // Return Button
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: actionYellow,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: 8,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

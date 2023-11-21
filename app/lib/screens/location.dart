import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
import 'package:provider/provider.dart';

import '../controllers/restaurants_controller.dart';
import '../models/restaurant.dart';
import '../styles/color.dart';

class LocationScreen extends StatefulWidget {

  final List<Restaurant> restaurants;
  const LocationScreen(this.restaurants, {Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

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

                print(widget.restaurants.length);
                for(var restaurant in widget.restaurants) {
                  // print(restaurant.name);
                }

                final local = context.watch<RestaurantsController>();
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(location.lat, location.long),
                    zoom: 18,
                  ),
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: local.onMapCreated,
                  markers: local.markers,
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
                  borderRadius: BorderRadius.circular(20),
                ),
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

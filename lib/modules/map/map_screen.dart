// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit()
        ..getCurrentLocation()
        ..getPolyLine(),
      child: BlocConsumer<MapCubit, MapStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var mapCubit = MapCubit.get(context);
          return state == GetCurrentLocationSuccessState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: mapCubit.sourceLocation,
                    zoom: 12.5,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('Mark1'),
                      position: mapCubit.sourceLocation,
                    ),
                    Marker(
                      markerId: const MarkerId('Mark2'),
                      position: mapCubit.destination,
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('Route'),
                      points: mapCubit.polyPoints,
                      color: Colors.black,
                      width: 6,
                    )
                  },
                );
        },
      ),
    );
  }
}

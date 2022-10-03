// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../shared/components/constants.dart';
import 'states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(InitState());

  static MapCubit get(context) => BlocProvider.of(context);

  LatLng sourceLocation = const LatLng(37.33500926, -122.03272188);
  LatLng destination = const LatLng(37.33429383, -122.06600055);

  void getCurrentLocation() {
    emit(GetCurrentLocationLoadingState());
    Location currentLocation = Location();
    currentLocation.getLocation().then(
      (value) {
        sourceLocation = LatLng(value.latitude!, value.longitude!);
        emit(GetCurrentLocationSuccessState());
      },
    ).catchError(
      (onError) {
        emit(GetCurrentLocationErrorState());
      },
    );
  }

  List<LatLng> polyPoints = [];
  void getPolyLine() {
    emit(GetPolyPointsLoadingState());
    PolylinePoints polylinePoints = PolylinePoints();
    polylinePoints
        .getRouteBetweenCoordinates(
      googleMapKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    )
        .then((value) {
      print('${value.errorMessage}');
      print('${value.status}');
      print(
          'this list ${PointLatLng(sourceLocation.latitude, sourceLocation.longitude)}');
      print(
          'this list ${PointLatLng(destination.latitude, destination.longitude)}');
      print('this list ${value.points}');
      if (value.points.isNotEmpty) {
        value.points.forEach((PointLatLng point) {
          polyPoints.add(LatLng(point.latitude, point.longitude));
          emit(GetPolyPointsSuccessState());
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}

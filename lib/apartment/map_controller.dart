import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:apartment_app/apartment/map_states.dart';

class MapController extends Cubit<MapStates> {
  MapController() : super(MapInitialState()) {
    getUserLocation();
  }
  LatLng _latLng = LatLng(30.033333, 31.233334);
  LatLng get latLng => _latLng;
  Placemark _placeMark = Placemark();
  Placemark get placeMark => _placeMark;
  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  Future<void> getUserLocation() async {
    emit(MapLoadingState());
    try {
      bool isDone = await _mapStatus();

      if (isDone) {
        Position userPosition = await Geolocator.getCurrentPosition();
        List<Placemark> marks = await placemarkFromCoordinates(
            userPosition.latitude, userPosition.longitude);
        _placeMark = marks[0];
        _latLng = LatLng(userPosition.latitude, userPosition.longitude);
        emit(GetUserLocationState());
      } else {
        emit(MapStatusErrorState());
      }
    } catch (e) {
      emit(MapErrorState());
    }
  }

  Future<bool> _mapStatus() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    bool service = await Geolocator.isLocationServiceEnabled();
    if (!service) return false;

    return true;
  }

  Future<void> searchLocation(String address) async {
    _markers.clear();
    emit(MapLoadingState());
    try {
      bool isDone = await _mapStatus();

      if (isDone) {
        List<Location> locations = await locationFromAddress(address);
        _latLng = LatLng(locations[0].latitude, locations[0].longitude);
        List<Placemark> marks =
            await placemarkFromCoordinates(_latLng.latitude, _latLng.longitude);
        _placeMark = marks[0];
        _markers.add(Marker(
            markerId: MarkerId(locations[0].timestamp.toString()),
            position: LatLng(locations[0].latitude, locations[0].longitude)));
        emit(SearchLocationState());
      } else {
        emit(MapStatusErrorState());
      }
    } catch (e) {
      emit(MapErrorState());
    }
  }
}

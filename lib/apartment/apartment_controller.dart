// Last Session
// filter
// map

// getCategories //
// getRecommended
// getNaerbyToYou
// getWishlist //
// getSpaces //
// add&Remove wishlist //
// addApartement //
// getUserApartment //
// editApartment
// deleteApartment //

/*
  how to write HTTP method =>
    - function type ( Future, void, return type 'dynamic, bool, etc' )
    - require parameters ? ( positional & non positional )
    - async & await 

*/

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/apartment/apartment_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String domainAddress =
    // 'https://instant-366613-default-rtdb.firebaseio.com';

    //'https://apartment-f33d7-default-rtdb.firebaseio.com';
    'https://instantapp-cc7bc-default-rtdb.firebaseio.com';

class ApartmentController extends Cubit<ApartmentState> {
  ApartmentController() : super(ApartmentInitialState()) {
    getSpaces();
    getRecommanded();
    getWishlist();
  }

  List<SpaceModel> _spaces = [];
  List<SpaceModel> get allSpaces => _spaces;

  List<SpaceModel> _userSpaces = [];
  List<SpaceModel> get allUserSpaces => _userSpaces;

  List<SpaceModel> _wishlist = [];
  List<SpaceModel> get wishlistSpaces => _wishlist;

  List<SpaceModel> _nearbyApartment = [];
  List<SpaceModel> get nearbyApartment => _nearbyApartment;

  EditApartmentModel? editApartmentModel;
  List<SpaceModel> _recommen = [];
  List<SpaceModel> get recommmanded => _recommen;

  Future<void> getWishlist() async {
    emit(GetFavLoadingState());
    try {
      http.Response res =
          await http.get(Uri.parse('$domainAddress/wishlist.json'));
      Map data = json.decode(res.body);
      if (res.statusCode == 200) {
        data.forEach((key, value) {
          for (SpaceModel space in _spaces) {
            if (value['spaceId'] == space.spaceId) {
              space.isFav = true;
              _wishlist.add(space);
            }
            break;
          }
        });
        emit(GetFavSuccessState());
      } else {
        emit(GetFavErrorState());
      }
    } catch (e) {
      emit(GetFavErrorState());
    }
  }

  Future<void> getSpaces() async {
    emit(GetSpaceLoadingState());
    try {
      http.Response res =
          await http.get(Uri.parse('$domainAddress/spaces.json'));
      Map data = json.decode(res.body);

      if (res.statusCode == 200) {
        _spaces.clear();
        data.forEach((key, value) {
          SpaceModel space = SpaceModel.fromJson(key, value);
          if (space.userId == 1) {
            _userSpaces.add(space);
          }
          _spaces.add(space);
        });
        emit(GetSpaceSuccessState());
      } else {
        emit(GetSpaceErrorState());
      }
    } catch (e) {
      emit(GetSpaceErrorState());
    }
  }

  Future<void> addSpace(SpaceModel space) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    Map sendingData = {
      'userId': shared.getInt('userId'),
      'addType': space.addType,
      'categoryId': space.categoryId,
      'rentType': space.rentType,
      'spaceArea': space.spaceArea,
      'spaceBathRoom': space.spaceBathRoom,
      'spaceBeds': space.spaceBeds,
      'spaceDescription': space.spaceDescription,
      'spaceImgs': space.spaceImgs,
      'spaceLat': space.spaceLat,
      'spaceLng': space.spaceLng,
      'spaceLocation': space.spaceLocation,
      'spaceName': space.spaceName,
      'spacePrice': space.spacePrice,
    };

    try {
      http.Response res = await http.post(
          Uri.parse('$domainAddress/spaces.json'),
          body: json.encode(sendingData));
      if (res.statusCode == 200) {
        Map data = json.decode(res.body);
        space.spaceId = data['name'];
        _spaces.add(space);
        _userSpaces.add(space);
        emit(AddApartmentSuccessState());
      } else {
        emit(AddApartmentErrorState());
      }
    } catch (e) {
      //  print(e);
      emit(AddApartmentErrorState());
    }
  }

  Future<void> handleIsFav(SpaceModel space) async {
    bool isSuccess = false;
    if (space.isFav) {
      isSuccess = await _removeFromWishlist(space);
    } else {
      isSuccess = await _addToWishlist(space);
    }
    emit(isSuccess ? IsFavSuccessState() : IsFavErrorState());
  }

  Future<bool> _addToWishlist(SpaceModel space) async {
    try {
      Map sendData = {'spaceId': space.spaceId, 'userId': 1};
      http.Response res = await http.post(
          Uri.parse('$domainAddress/wishlist.json'),
          body: json.encode(sendData));
      if (res.statusCode == 200) {
        Map data = json.decode(res.body);
        space.isFav = true;
        space.wishlistid = data['name'];
        _wishlist.add(space);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _removeFromWishlist(SpaceModel space) async {
    try {
      http.Response res = await http.delete(
          Uri.parse('$domainAddress/wishlist/${space.wishlistid}.json'));
      if (res.statusCode == 200) {
        space.isFav = false;
        for (int i = 0; i < _wishlist.length; i++) {
          if (space.spaceId == _wishlist[i].spaceId) {
            _wishlist.removeAt(i);
            break;
          }
        }
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteApartment(SpaceModel space) async {
    emit(DeleteApartmentLoadingState());

    try {
      http.Response res = await http
          .delete(Uri.parse('$domainAddress/spaces/${space.spaceId}.json'));
      if (res.statusCode == 200) {
        for (int i = 0; i < _spaces.length; i++) {
          if (space.spaceId == _spaces[i].spaceId) {
            _spaces.removeAt(i);
            break;
          }
        }
        for (int i = 0; i < _userSpaces.length; i++) {
          if (space.spaceId == _userSpaces[i].spaceId) {
            _userSpaces.removeAt(i);
            break;
          }
        }
        emit(DeleteApartmentSuccessState());
      } else {
        emit(DeleteApartmentErrorState());
      }
    } catch (e) {
      emit(DeleteApartmentErrorState());
    }
  }

  void prepareEditScreen(SpaceModel spaceModel) {
    editApartmentModel = EditApartmentModel(
        descriptionController:
            TextEditingController(text: spaceModel.spaceDescription),
        bedController:
            TextEditingController(text: spaceModel.spaceBeds.toString()),
        areaController:
            TextEditingController(text: spaceModel.spaceArea.toString()),
        bathController:
            TextEditingController(text: spaceModel.spaceBathRoom.toString()),
        addType: spaceModel.addType,
        addressController:
            TextEditingController(text: spaceModel.spaceLocation),
        nameController: TextEditingController(text: spaceModel.spaceName),
        priceController:
            TextEditingController(text: spaceModel.spacePrice.toString()),
        rentType: spaceModel.rentType,
        selectedCategoryId: spaceModel.categoryId);
  }

  Future<void> updateApartment(SpaceModel space) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    Map sendingData = {
      'userId': space.userId, // shared.getInt('userId'),
      'addType': space.addType,
      'categoryId': space.categoryId,
      'rentType': space.rentType,
      'spaceArea': space.spaceArea,
      'spaceBathRoom': space.spaceBathRoom,
      'spaceBeds': space.spaceBeds,
      'spaceDescription': space.spaceDescription,
      'spaceImgs': space.spaceImgs,
      'spaceLat': space.spaceLat,
      'spaceLng': space.spaceLng,
      'spaceLocation': space.spaceLocation,
      'spaceName': space.spaceName,
      'spacePrice': space.spacePrice,
    };
    try {
      http.Response res = await http.put(
          Uri.parse('$domainAddress/spaces/${space.spaceId}.json'),
          body: json.encode(sendingData));
      if (res.statusCode == 200) {
        emit(EditApartmentSuccessState());
      } else {
        emit(EditApartmentErrorState());
      }
      print(space.spaceId);
    } catch (e) {
      print(e);
      emit(EditApartmentErrorState());
    }
  }

  void findNearby(LatLng latLng) {
    emit(FindNearbyLoadingState());
    _nearbyApartment.clear();
    _spaces.forEach((element) {
      double distance = Geolocator.distanceBetween(latLng.latitude,
          latLng.longitude, element.spaceLat, element.spaceLng);
      print(distance);
      //distance == 12409473.235681368
      if (distance <= 10) {
        _nearbyApartment.add(element);
      }
    });
    emit(FindNearbyState());
  }

  Future<void> getRecommanded() async {
    emit(GetRecommandedLoadingState());
    try {
      http.Response res =
          await http.get(Uri.parse('$domainAddress/spaces.json'));
      Map data = json.decode(res.body);
      if (res.statusCode == 200) {
        _recommen.clear();
        _recommen.clear();
        data.forEach((key, value) {
          if (value['recommended'] == true) {
            _recommen.add(SpaceModel.fromJson(key, value));
          }
        });
        emit(GetRecommandedSucessState());
      } else {
        print('herrrrrrr');
        emit(GetRecommandedErrorState());
      }
    } catch (e) {
      print(e);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa');
      emit(GetRecommandedErrorState());
    }
  }
}
//: 95695.28213277459//
// 99947.42418495173
// 198863.3217789883//

// 369835.1109733902

// 12174.396237179368//
// 28646.0614366081//
// 116456.61592737901//

// 404962.58313669247//

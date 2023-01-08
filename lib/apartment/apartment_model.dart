import 'package:flutter/cupertino.dart';

class SpaceModel {
  int userId;
  String spaceId;
  String addType;
  String categoryId;
  String rentType;
  num spaceArea;
  int spaceBathRoom;
  int spaceBeds;
  String spaceDescription;
  List spaceImgs;
  double spaceLat;
  double spaceLng;
  String spaceLocation;
  String spaceName;
  num spacePrice;
  bool isFav;
  String wishlistid;
 dynamic recommended;

  SpaceModel(
      {  this.recommended,
      required this.userId,
      required this.spaceId,
      required this.addType,
      required this.categoryId,
      required this.rentType,
      required this.spaceArea,
      required this.spaceBathRoom,
      required this.spaceBeds,
      required this.spaceDescription,
      required this.spaceImgs,
      required this.spaceLat,
      required this.spaceLng,
      required this.spaceLocation,
      required this.spaceName,
      required this.spacePrice,
      required this.isFav,
      required this.wishlistid});

  factory SpaceModel.fromJson(String id, Map data) {
    return SpaceModel(
        recommended: data['recommended'],
        userId: data['userId'],
        spaceId: id,
        addType: data['addType'],
        categoryId: data['categoryId'],
        rentType: data['rentType'],
        spaceArea: data['spaceArea'],
        spaceBathRoom: data['spaceBathRoom'],
        spaceBeds: data['spaceBeds'],
        spaceDescription: data['spaceDescription'],
        spaceImgs: data['spaceImgs'],
        spaceLat: data['spaceLat'],
        spaceLng: data['spaceLng'],
        spaceLocation: data['spaceLocation'],
        spaceName: data['spaceName'],
        spacePrice: data['spacePrice'],
        isFav: false,
        wishlistid: '');
  }
}

class EditApartmentModel {
  TextEditingController descriptionController;
  TextEditingController addressController;
  TextEditingController priceController;
  TextEditingController nameController;
  TextEditingController areaController;
  TextEditingController bathController;
  TextEditingController bedController;
  String rentType;
  String addType;
  String selectedCategoryId;

  EditApartmentModel(
      {required this.descriptionController,
      required this.addressController,
      required this.priceController,
      required this.nameController,
      required this.areaController,
      required this.bathController,
      required this.bedController,
      required this.rentType,
      required this.addType,
      required this.selectedCategoryId});
}

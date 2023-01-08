import 'package:apartment_app/shared/shared_widget/snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_model.dart';
import 'package:apartment_app/apartment/apartment_states.dart';
import 'package:apartment_app/apartment/category_controller.dart';
import 'package:apartment_app/apartment/category_model.dart';
import 'package:apartment_app/apartment/map_controller.dart';
import 'dart:io';
import '../../shared/shared_theme/shared_colors.dart';
import '../../shared/shared_theme/shared_fonts.dart';
import '../../shared/shared_widget/field_components.dart';

class EditApartment extends StatefulWidget {
  SpaceModel spaceModel;
  EditApartment(this.spaceModel, {super.key});

  @override
  State<EditApartment> createState() => _EditApartmentState();
}

class _EditApartmentState extends State<EditApartment> {
  File? pickedImage;
  @override
  void initState() {
    BlocProvider.of<ApartmentController>(context)
        .prepareEditScreen(widget.spaceModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentController, ApartmentState>(
        builder: (context, state) {
      ApartmentController controller =
          BlocProvider.of<ApartmentController>(context);
      return Scaffold(
        backgroundColor: SharedColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location', style: SharedFonts.subBlackFont),
              Row(
                children: [
                  Icon(Icons.location_on,
                      color: SharedColors.orangeColor, size: 17),
                  Text('  Cairo, Egypt  ', style: SharedFonts.subBlackFont),
                  Icon(Icons.arrow_downward,
                      color: SharedColors.orangeColor, size: 17),
                ],
              ),
            ],
          ),
          actions: [
            Icon(Icons.notifications, color: SharedColors.orangeColor, size: 20)
          ],
        ),
        body: ListView(padding: EdgeInsets.all(8), children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              getImg(ImageSource.camera);
                            },
                            child: Text('Camera',
                                style: SharedFonts.primaryBlackFont),
                          ),
                          InkWell(
                            onTap: () {
                              getImg(ImageSource.gallery);
                            },
                            child: Text('Gallery',
                                style: SharedFonts.primaryBlackFont),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              height: 195,
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(bottom: 7.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  image: pickedImage == null
                      ? DecorationImage(
                          image: NetworkImage(
                              'https://t4.ftcdn.net/jpg/00/89/55/15/360_F_89551596_LdHAZRwz3i4EM4J0NHNHy2hEUYDfXc0j.jpg'),
                          fit: BoxFit.fill)
                      : DecorationImage(
                          image: FileImage(pickedImage!), fit: BoxFit.fill)),
              alignment: Alignment.topRight,
            ),
          ),
          Text('\n Name', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.nameController,
            icon: Icons.bathroom,
            hintTxt: 'Enter Name ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\n Discription', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.descriptionController,
            icon: Icons.text_fields_sharp,
            hintTxt: 'Enter Discription ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\n Address', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.addressController,
            icon: Icons.location_on,
            hintTxt: 'Enter Address ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\n Area', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.areaController,
            icon: Icons.area_chart,
            hintTxt: 'Enter Area ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\n BathRoom', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.bathController,
            icon: Icons.bathroom,
            hintTxt: 'Enter BathRoom ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\n Beds', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.bedController,
            icon: Icons.bed,
            hintTxt: 'Enter Beds ',
            type: TextInputType.name,
            onsumbit: () {},
          )),
          Text('\nPrice', style: SharedFonts.subBlackFont),
          CustomField(FieldModel(
            controller: controller.editApartmentModel!.priceController,
            icon: Icons.price_change,
            hintTxt: 'Enter price ',
            type: TextInputType.number,
            onsumbit: () {},
          )),
          ListTile(
            title: Text('Add Type', style: SharedFonts.subBlackFont),
            subtitle: Text(controller.editApartmentModel!.addType,
                style: SharedFonts.subGreyFont),
            trailing: PopupMenuButton(
              icon: Icon(Icons.arrow_downward, color: SharedColors.orangeColor),
              iconSize: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: Text('Rent'),
                    value: 'rent',
                  ),
                  PopupMenuItem(
                    child: Text('Sell'),
                    value: 'sell',
                  ),
                ];
              },
              onSelected: (v) {
                setState(() {
                  controller.editApartmentModel!.addType = v;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Rent Type', style: SharedFonts.subBlackFont),
            subtitle: Text(controller.editApartmentModel!.rentType,
                style: SharedFonts.subGreyFont),
            trailing: PopupMenuButton(
              icon: Icon(Icons.arrow_downward, color: SharedColors.orangeColor),
              iconSize: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: Text('Month'),
                    value: 'month',
                  ),
                  PopupMenuItem(
                    child: Text('year'),
                    value: 'year',
                  ),
                ];
              },
              onSelected: (v) {
                setState(() {
                  controller.editApartmentModel!.rentType = v;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Choose Category', style: SharedFonts.subBlackFont),
            subtitle: Text(controller.editApartmentModel!.selectedCategoryId,
                style: SharedFonts.subGreyFont),
            trailing: PopupMenuButton(
              icon: Icon(Icons.arrow_downward, color: SharedColors.orangeColor),
              iconSize: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              itemBuilder: (BuildContext context) {
                CategoryController categoryController =
                    BlocProvider.of<CategoryController>(context);
                return <PopupMenuEntry<String>>[
                  for (CategoryModel category in categoryController.categories)
                    PopupMenuItem(
                      child: Text('${category.categoryName}'),
                      value: category.categoryId,
                    ),
                ];
              },
              onSelected: (v) {
                setState(() {
                  controller.editApartmentModel!.selectedCategoryId = v;
                });
              },
            ),
          ),
          TextButton(
              onPressed: () async {
                MapController mapController =
                    BlocProvider.of<MapController>(context);
                ApartmentController apartmentController =
                    BlocProvider.of<ApartmentController>(context);
                await mapController.getUserLocation();
                widget.spaceModel.userId = 1;
                widget.spaceModel.addType =
                    controller.editApartmentModel!.addType;
                widget.spaceModel.categoryId =
                    controller.editApartmentModel!.selectedCategoryId;
                widget.spaceModel.rentType =
                    controller.editApartmentModel!.rentType;
                widget.spaceModel.spaceArea = num.parse(
                    controller.editApartmentModel!.areaController.text);
                widget.spaceModel.spaceBathRoom = int.parse(
                    controller.editApartmentModel!.bathController.text);
                widget.spaceModel.spaceBeds = int.parse(
                    controller.editApartmentModel!.bedController.text);
                widget.spaceModel.spaceDescription =
                    controller.editApartmentModel!.descriptionController.text;
                widget.spaceModel.spaceImgs = [
                  "https://www.republicapartments.com.au/site/wp-content/uploads/2021/04/republic-apartments-brisbane-accom-2.jpg",
                  "https://www.astraapartments.com.au/wp-content/uploads/2020/03/Hero-Brisbane-Boundary-1-bed-study-corporate-apartment-dining-lounge-2500x1667-1.jpg",
                  "https://q-xx.bstatic.com/xdata/images/hotel/840x460/257586302.jpg?k=2d9e34ee0b3df682593db8618338217247839667fde91bbf73fe6b34438bb90c&o=",
                  "https://cf.bstatic.com/xdata/images/hotel/max1024x768/340460315.jpg?k=50b982cb670422986506543422944d4cdf4f4f3e715feb6feef71abaeacecaa0&o=&hp=1",
                  "https://imageio.forbes.com/specials-images/imageserve/5fbd51681f494fecd3283435/0x0.jpg?format=jpg&width=1200"
                ];
                widget.spaceModel.spaceLat = mapController.latLng.latitude;
                widget.spaceModel.spaceLng = mapController.latLng.longitude;
                widget.spaceModel.spaceLocation =
                    controller.editApartmentModel!.addressController.text;
                widget.spaceModel.spaceName =
                    controller.editApartmentModel!.nameController.text;
                widget.spaceModel.spacePrice = num.parse(
                    controller.editApartmentModel!.priceController.text);
                widget.spaceModel.isFav = false;
                widget.spaceModel.wishlistid = '';
                controller.updateApartment(widget.spaceModel);
              },
              child: Text(
                'Submit   ',
                style: TextStyle(
                    backgroundColor: SharedColors.orangeColor,
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              )),
        ]),
      );
    });
  }

  void getImg(ImageSource source) async {
    XFile? img = await ImagePicker().pickImage(source: source);
    try {
      setState(() {
        pickedImage = File(img!.path);
      });
    } catch (e) {}
  }
}

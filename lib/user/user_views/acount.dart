import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../shared/shared_theme/shared_colors.dart';
import '../../shared/shared_theme/shared_fonts.dart';
import '../../shared/shared_widget/field_components.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({super.key});
  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  bool gender = false;
  bool editable = false;
  File? pickedImage;
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.backGroundColor,
        appBar: AppBar(
          backgroundColor: SharedColors.backGroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height / 1.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: pickedImage == null
                            ? DecorationImage(
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq-gu-WXjo1k_NzarGJkqZBB7lRN6qtnkMY5RzJDCK&s'),
                                fit: BoxFit.fill)
                            : DecorationImage(
                                image: FileImage(pickedImage!),
                                fit: BoxFit.fill)),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: SharedColors.orangeColor,
                      iconSize: 35.0,
                      onPressed: editable
                          ? () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200.0,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              getImg(ImageSource.camera);
                                            },
                                            child: Text('Camera',
                                                style: SharedFonts
                                                    .primaryBlackFont),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              getImg(ImageSource.gallery);
                                            },
                                            child: Text('Gallery',
                                                style: SharedFonts
                                                    .primaryBlackFont),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          : () {},
                    ),
                  ),
                  ListTile(
                    title: Text('Name', style: SharedFonts.subBlackFont),
                    leading: Icon(Icons.person, color: SharedColors.greyColor),
                    trailing: IconButton(
                      icon: Icon(editable ? Icons.done : Icons.edit),
                      color: SharedColors.orangeColor,
                      iconSize: 20.0,
                      onPressed: () {
                        setState(() {
                          editable = !editable;
                        });
                      },
                    ),
                  ),
                  CustomField(FieldModel(
                      controller: userNameController,
                      icon: Icons.person,
                      hintTxt: 'Bassel',
                      type: TextInputType.name,
                      enabled: editable)),
                  ListTile(
                    title: Text('Email', style: SharedFonts.subBlackFont),
                    leading: Icon(Icons.person, color: SharedColors.greyColor),
                  ),
                  CustomField(FieldModel(
                      controller: emailController,
                      icon: Icons.email,
                      hintTxt: 'email',
                      type: TextInputType.emailAddress,
                      enabled: editable)),
                  ListTile(
                    title:
                        Text('Phone Number', style: SharedFonts.subBlackFont),
                    leading: Icon(Icons.person, color: SharedColors.greyColor),
                  ),
                  CustomField(FieldModel(
                      controller: phoneController,
                      icon: Icons.phone,
                      hintTxt: '01010101101',
                      type: TextInputType.number,
                      enabled: editable)),
                  Row(children: [
                    Checkbox(
                        checkColor: Colors.white,
                        activeColor: SharedColors.blackColor,
                        value: gender,
                        onChanged: editable
                            ? (x) {
                                setState(() {
                                  gender = x!;
                                });
                              }
                            : (x) {}),
                    Text(
                      'Male',
                      style: SharedFonts.subGreyFont,
                    ),
                    Checkbox(
                        checkColor: Colors.white,
                        activeColor: SharedColors.blackColor,
                        value: !gender,
                        onChanged: editable
                            ? (x) {
                                setState(() {
                                  gender = !x!;
                                });
                              }
                            : (x) {}),
                    Text(
                      'FeMale',
                      style: SharedFonts.subGreyFont,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ));
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

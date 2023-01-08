import 'package:flutter/material.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/field_components.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  GlobalKey<FormState> userNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String gender = 'Select Gender';
  String birthDate = 'Select Birthdate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.backGroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text('  Welcome!\n   Register', style: TextStyle(color: SharedColors.blackColor, fontSize: 45, fontWeight: FontWeight.bold),),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: ListView(
                    children: [
                      CustomField(
                        FieldModel(
                          controller: userNameController,
                          icon: Icons.person,
                          labelTxt: 'User Name',
                          type: TextInputType.text,
                          key: userNameKey
                        )
                      ),
                      CustomField(
                        FieldModel(
                          controller: emailController,
                          icon: Icons.email,
                          labelTxt: 'Email Address',
                          type: TextInputType.emailAddress,
                          key: emailKey
                        )
                      ),
                      CustomField(
                        FieldModel(
                          controller: passwordController,
                          icon: Icons.lock,
                          labelTxt: 'Password',
                          type: TextInputType.text,
                          isSecure: true,
                          fieldType: FieldType.password,
                          key: passwordKey
                        )
                      ),
                      ListTile(
                        title: Text('Gender', style: SharedFonts.subBlackFont),
                        subtitle: Text(gender, style: SharedFonts.subGreyFont),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.arrow_downward, color: SharedColors.orangeColor),
                          iconSize: 20.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem(
                                child: Text('Male'),
                                value: 'male',
                              ),
                              PopupMenuItem(
                                child: Text('FeMale'),
                                value: 'female',
                              ),
                            ];
                          },
                          onSelected: (v) {
                            setState(() {
                              gender = v;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Birthdate', style: SharedFonts.subBlackFont),
                        subtitle: Text(birthDate, style: SharedFonts.subGreyFont),
                        trailing: Icon(Icons.calendar_month, color: SharedColors.orangeColor, size: 20.0,),
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(1990),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2005)
                          );
                          setState(() {
                            birthDate = selectedDate.toString().substring(0, 10);
                          });
                        },
                      ),
                      Column(
                        children: [
                          TextButton(
                            child: Text('Register', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                            style: TextButton.styleFrom(
                              backgroundColor: SharedColors.orangeColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                              fixedSize: Size(100, 50)
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Some Field Required', style: TextStyle(color: Colors.white)),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: SharedColors.orangeColor,
                                  )
                                );
                              }
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text('\nHave an account? Login   \n', style: SharedFonts.orangeFont)
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
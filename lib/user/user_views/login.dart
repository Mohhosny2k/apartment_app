import 'package:flutter/material.dart';
import 'package:apartment_app/navigation/navigation_screens/navigation_screen.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';
import 'package:apartment_app/shared/shared_widget/field_components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView(
              children: [
                Text(
                  '  Welcome!\n   Login',
                  style: TextStyle(
                      color: SharedColors.blackColor,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  margin: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        CustomField(FieldModel(
                            controller: emailController,
                            icon: Icons.email,
                            labelTxt: 'Email Address',
                            type: TextInputType.emailAddress,
                            onsumbit: () {},
                            key: emailKey)),
                        CustomField(FieldModel(
                            controller: passwordController,
                            icon: Icons.lock,
                            labelTxt: 'Password',
                            type: TextInputType.text,
                            isSecure: true,
                            fieldType: FieldType.password,
                            onsumbit: () {},
                            key: passwordKey)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: () {},
                              child: Text('\nForgot Password?   \n',
                                  style: SharedFonts.subGreyFont)),
                        ),
                        Column(
                          children: [
                            TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: SharedColors.orangeColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  fixedSize: Size(100, 50)),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Some Field Required',
                                        style: TextStyle(color: Colors.white)),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: SharedColors.orangeColor,
                                  ));
                                } else {
                                  SharedPreferences save =
                                      await SharedPreferences.getInstance();
                                  save.setInt('userId', 1);                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => NavigationScreen()));
                                }
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'signup');
                                  },
                                  child: Text(
                                      '\nDont Have an account? SignUp   \n',
                                      style: SharedFonts.orangeFont)),
                            ),
                          ],
                        )
                      ],
                    ),
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

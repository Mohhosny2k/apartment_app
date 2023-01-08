import 'package:apartment_app/navigation/navigation_screens/navigation_screen.dart';
import 'package:apartment_app/user/user_views/login.dart';
import 'package:apartment_app/user/user_views/user_apartments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/apartment/apartment_controller.dart';
import 'package:apartment_app/apartment/apartment_views/add_apartmene.dart';
import 'package:apartment_app/apartment/category_controller.dart';
import 'package:apartment_app/apartment/map_controller.dart';
import 'package:apartment_app/navigation/navigation_controller.dart';
import 'package:apartment_app/user/user_views/aboutus_screen.dart';
import 'package:apartment_app/user/user_views/acount.dart';
import 'package:apartment_app/user/user_views/contact_screen.dart';
import 'package:apartment_app/user/user_views/privacy_screen.dart';
import 'package:apartment_app/user/user_views/setting.dart';
import 'package:apartment_app/user/user_views/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool user = false;
  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationController(),
        ),
        BlocProvider(
          create: (context) => ApartmentController(),
        ),
        BlocProvider(
          create: (context) => CategoryController(),
        ),
        BlocProvider(
          create: (context) => MapController(),
        ),
      ],
      child: MaterialApp(
        home: user ? NavigationScreen() : LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          'setting': (context) => SettingScreen(),
          'addApartment': (context) => AddApartment(),
          'contact': (context) => ContactScreen(),
          'about': (context) => AboutScreen(),
          'privacy': (context) => PrivacyScreen(),
          'signup': (context) => SignupScreen(),
          'account': (context) => AcountScreen(),
          'userApartment': (context) => UserApartment()
        },
      ),
    );
  }

  check() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
     int id = sharedPreferences.getInt('userId')!;
     if (id != null) {
      user = true;
     } else {
      user = false;
     }
    } catch (e) {
      user = false;
    }
    setState(() {});
  }
}

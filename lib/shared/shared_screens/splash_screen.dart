import 'package:flutter/material.dart';
import 'package:apartment_app/navigation/navigation_screens/navigation_screen.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  bool first = true;
  @override
  void didChangeDependencies() async {
    if (first) {
      first = false;
      await Future.delayed(Duration(seconds: 1), () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NavigationScreen()));
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.home,
          color: SharedColors.orangeColor,
          size: 250.0,
        ),
      ),
    );
  }
}

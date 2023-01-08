import 'package:apartment_app/apartment/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/navigation/navigation_controller.dart';
import 'package:apartment_app/navigation/navigation_states.dart';
import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:apartment_app/shared/shared_theme/shared_fonts.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationController, NavigationStates>(
      builder: (context, state) {
        if (state is NavigationChangeState) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
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
                          Text(
                              '''  ${BlocProvider.of<MapController>(context).placeMark.country}  ''',
                              style: SharedFonts.subBlackFont),
                          Icon(Icons.arrow_downward,
                              color: SharedColors.orangeColor, size: 17),
                        ],
                      ),
                    ],
                  ),
                  actions: [
                    Icon(Icons.notifications,
                        color: SharedColors.orangeColor, size: 20)
                  ],
                ),
                backgroundColor: SharedColors.backGroundColor,
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    navItem('Home', Icons.home),
                    navItem('Map', Icons.location_on),
                    navItem('Wishlist', Icons.favorite),
                    navItem('More', Icons.more_horiz),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  selectedIconTheme: IconThemeData(
                      color: SharedColors.orangeColor, size: 20.0),
                  unselectedIconTheme:
                      IconThemeData(color: SharedColors.greyColor, size: 18.0),
                  selectedLabelStyle: SharedFonts.subBlackFont,
                  unselectedLabelStyle: SharedFonts.subGreyFont,
                  selectedItemColor: SharedColors.orangeColor,
                  unselectedItemColor: SharedColors.greyColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: state.currentIndex,
                  onTap: (i) {
                    BlocProvider.of<NavigationController>(context).move(i);
                  },
                ),
                body: state.selectedScreen),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  BottomNavigationBarItem navItem(String title, IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), label: title);
  }
}

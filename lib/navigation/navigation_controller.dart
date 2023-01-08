import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apartment_app/navigation/navigation_states.dart';
import 'package:apartment_app/shared/shared_screens/home_page.dart';
import 'package:apartment_app/shared/shared_screens/map_screen.dart';
import 'package:apartment_app/shared/shared_screens/more_screen.dart';
import 'package:apartment_app/shared/shared_screens/wishlist_screen.dart';

class NavigationController extends Cubit<NavigationStates> {
  NavigationController() : super(NavigationChangeState(0, HomePage()));

  final List _screens = [
    HomePage(),
    MapScreen(),
    WishlistScreen(),
    MoreScreen()
  ];

  void move(int index) {
    emit(NavigationChangeState(index, _screens[index]));
  }
}

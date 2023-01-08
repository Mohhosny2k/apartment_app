import 'package:flutter/material.dart';

abstract class NavigationStates {}

class NavigationChangeState extends NavigationStates {
  int currentIndex;
  Widget selectedScreen;
  NavigationChangeState(this.currentIndex, this.selectedScreen);
}

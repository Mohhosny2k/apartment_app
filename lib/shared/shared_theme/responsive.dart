double responsiveHomeContainer(double screenHeight) {
  if (screenHeight <= 545) {
    return screenHeight / 1.7;
  } else if (screenHeight <= 800) {
    return screenHeight / 2.3;//2.7
  } else {
    return screenHeight / 2;
  }
}

double horiSpaceWidgetImage(double screenWidth) {
  if (screenWidth <= 330) {
    return 80.0;
  } else if (screenWidth <= 400) {
    return 125.0;
  } else {
    return 80;//150
  }
}

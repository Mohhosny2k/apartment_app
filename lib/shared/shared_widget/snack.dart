import 'package:apartment_app/shared/shared_theme/shared_colors.dart';
import 'package:flutter/material.dart';

SnackBar snack(String content, Color color) {
  return SnackBar(
    content: Text('$content', style: TextStyle(color: Colors.white)),
    duration: Duration(seconds: 3),
    backgroundColor: SharedColors.orangeColor,
  );
}

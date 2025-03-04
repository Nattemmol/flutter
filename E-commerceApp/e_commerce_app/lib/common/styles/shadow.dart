import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NShadowStyle {
  static final verticalProductShadow = BoxShadow(
    color: NColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: NColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}

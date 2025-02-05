import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: NSizes.appBarHeight,
    left: NSizes.defaultSpace,
    bottom: NSizes.defaultSpace,
    right: NSizes.defaultSpace,
  );
}

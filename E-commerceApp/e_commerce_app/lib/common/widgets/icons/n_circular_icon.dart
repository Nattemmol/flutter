import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NCircularIcon extends StatelessWidget {
  const NCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = NSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null ?
        backgroundColor! :NHelperFunctions.isDarkMode(context)
            ? NColors.black.withOpacity(0.9)
            : NColors.white.withOpacity(0.9),
      ),
      child: IconButton(onPressed: () {}, icon: Icon(Iconsax.heart)),
    );
  }
}

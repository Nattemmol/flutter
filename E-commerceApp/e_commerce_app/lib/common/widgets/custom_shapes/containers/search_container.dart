import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/device/device_utility.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NSearchContainer extends StatelessWidget {
  const NSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: NSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
            width: NDeviceUtils.getScreenWidth(context),
            padding: EdgeInsets.symmetric(horizontal: NSizes.md),
            decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? NColors.dark
                      : NColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(NSizes.cardRadiusLg),
              border: showBorder
                  ? Border.all(color: dark ? NColors.dark : NColors.grey)
                  : null,
            ),
            child: Row(
              children: [
                Icon(icon, color: NColors.darkerGrey),
                SizedBox(width: NSizes.spaceBtwItems),
                Text(text, style: Theme.of(context).textTheme.bodySmall),
              ],
            )),
      ),
    );
  }
}

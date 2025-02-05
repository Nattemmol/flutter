import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/device/device_utility.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NAppBar extends StatelessWidget implements PreferredSizeWidget{
  const NAppBar({super.key, this.title,  this.showBackArrow = false, this.leadingIcon, this.actions, this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: NSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow? IconButton(onPressed: () =>Get.back(), icon: Icon(Iconsax.arrow_left, color: dark? NColors.white: NColors.dark)):
        leadingIcon != null? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)): null,
        title: title,
        actions: actions,
        ),
      );
  }
  @override
  Size get preferredSize => Size.fromHeight(NDeviceUtils.getBAppBarHeight());
}
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/device/device_utility.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NTabBar extends StatelessWidget implements PreferredSizeWidget{
  const NTabBar({
    super.key,
    required this.tabs,
  });
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? NColors.black : NColors.white,
      child: TabBar(
        isScrollable: true,
        indicatorColor: NColors.primary,
        labelColor: dark ? NColors.white : NColors.primary,
        tabs: tabs,
        unselectedLabelColor: NColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(NDeviceUtils.getBAppBarHeight());
}

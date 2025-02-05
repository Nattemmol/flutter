import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';



class NHomeAppBar extends StatelessWidget {
  const NHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(NTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: NColors.grey)),
          Text(NTexts.homeAppbarSubTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: NColors.white)),
        ],
      ),
      actions: [
        NCartCounterIcon(iconColor: NColors.white, onPressed: () {  },),
      ],
    );
  }
}


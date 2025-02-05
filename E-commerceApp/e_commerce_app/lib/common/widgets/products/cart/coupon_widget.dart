import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';


class NCouponCode extends StatelessWidget {
  const NCouponCode({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return NRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? NColors.dark: NColors.white,
      padding: const EdgeInsets.only(top: NSizes.sm, bottom: NSizes.sm, right: NSizes.sm, left: NSizes.md),
      child: Row(
        children: [
        Flexible(
          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Have a Promo code? Enter here',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none
                            ),
                          ),
        ),
        SizedBox(
          width: 80,
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: dark? NColors.white.withOpacity(0.5): NColors.dark.withOpacity(0.5),
            side: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
            onPressed: (){},
            child: const Text('Apply'))),
      ],
      ),
    );
  }
}
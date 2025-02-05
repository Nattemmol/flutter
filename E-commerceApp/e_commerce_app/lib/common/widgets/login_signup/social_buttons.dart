import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NSocialButtons extends StatelessWidget {
  const NSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
        decoration: BoxDecoration(border:Border.all(color: NColors.grey), borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed:() {},
          icon: Image(
            width: NSizes.iconMd,
            height: NSizes.iconMd,
            image: AssetImage(NImages.google),
          ),
        ),
        ),
        const SizedBox(width: NSizes.spaceBtwItems),
        Container(
        decoration: BoxDecoration(border:Border.all(color: NColors.grey), borderRadius: BorderRadius.circular(100)),
        child: IconButton(
          onPressed:() {},
          icon: Image(
            width: NSizes.iconMd,
            height: NSizes.iconMd,
            image: AssetImage(NImages.facebook),
          ),
        ),
        ),
      ],
    );
  }
}

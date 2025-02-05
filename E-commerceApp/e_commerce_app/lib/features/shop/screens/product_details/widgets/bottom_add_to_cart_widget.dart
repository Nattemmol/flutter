import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NBottomAddToCart extends StatelessWidget {
  const NBottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: NSizes.defaultSpace, vertical: NSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark? NColors.darkerGrey : NColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(NSizes.cardRadiusLg),
          topRight: Radius.circular(NSizes.cardRadiusLg),
        )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: NColors.darkGrey,
                  width: 40,
                  height: 40,
                  color:NColors.white
                  ),
              const SizedBox(width: NSizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: NSizes.spaceBtwItems),

              NCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: NColors.black,
                  width: 40,
                  height: 40,
                  color:NColors.white
                  ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(NSizes.md),
                backgroundColor: NColors.black,
                side: const BorderSide(color: NColors.black),
              ),
              child: const Text('Add to Cart'),),
          ],
        ),
    );
  }
}

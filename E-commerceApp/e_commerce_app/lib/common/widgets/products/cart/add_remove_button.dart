import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';



class NProductQuantityWithRemoveButton extends StatelessWidget {
  const NProductQuantityWithRemoveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: NSizes.md,
          color: NHelperFunctions.isDarkMode(context) ? NColors.darkerGrey : NColors.light,
        ),
        const SizedBox(width: NSizes.spaceBtwItems,),
    Text('2', style: Theme.of(context).textTheme.titleSmall,),
    const SizedBox(width: NSizes.spaceBtwItems,),
    NCircularIcon(
      icon: Iconsax.add,
      width: 32,
      height: 32,
      size: NSizes.md,
      color:NColors.white,
      backgroundColor: NColors.primary,
    ),
      ],
    );
  }
}

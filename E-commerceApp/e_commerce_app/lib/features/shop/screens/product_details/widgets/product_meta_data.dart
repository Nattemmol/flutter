import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/images/n_circular_image.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/texts/n_brand_title_text_with_verified_icon.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NProductMetaData extends StatelessWidget {
  const NProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = NHelperFunctions.isDarkMode(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            NRoundedContainer(
                          radius: NSizes.sm,
                          backgroundColor: NColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: NSizes.sm, vertical: NSizes.xs),
                          child: Text('25%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: NColors.black))
                                  ),
            const SizedBox(width: NSizes.spaceBtwItems),

            Text('\$250', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: NSizes.spaceBtwItems),
            const NProductPriceText(price: '150'),
            ],
        ),
        const SizedBox(height:NSizes.spaceBtwItems /1.5),
        
        const NProductTitleText(title: 'Green nike Sports Shirt'),
        const SizedBox(width: NSizes.spaceBtwItems / 1.5),

        Row(
          children: [
            const NProductTitleText(title: 'Status'),
            const SizedBox(width: NSizes.spaceBtwItems / 1.5),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(width: NSizes.spaceBtwItems / 1.5),

        Row(
          children: [
            NCircularImage(image: NImages.clothIcon,
            width: 32,
            height: 32,
            overlayColor: darkMode? NColors.white : NColors.black,
            ),
            NBrandTitleWithVerifiedIcon(title: 'Nike', brandTextSize : TextSizes.medius),
          ],
        ),

      ],
    );
  }
}

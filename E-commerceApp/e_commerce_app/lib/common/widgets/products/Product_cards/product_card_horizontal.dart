import 'package:e_commerce_app/common/styles/shadow.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/texts/n_brand_title_text.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NProductCardHorizontal extends StatelessWidget {
  const NProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(NSizes.productImageRadius),
          color: dark ? NColors.darkerGrey : NColors.softGrey,
        ),
        child: Row(
          children: [
            NRoundedContainer(
              height: 120,
              padding: const EdgeInsets.all(NSizes.sm),
              backgroundColor: dark? NColors.dark: NColors.light,
              child: Stack(
                children: [
                SizedBox(
                  height:120,
                  width: 120,
                  child: NRoundedImage(imageUrl: NImages.productImage1, applyImageRadius: true,),
                  ),
                 
                 Positioned(
                      top: 12,
                      child: NRoundedContainer(
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
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: NCircularIcon(
                          icon: Iconsax.heart, color: Colors.red),
                    ),
                ]
              ),
            ),
          SizedBox(
            width: 172,
            child: Padding(
              padding: EdgeInsets.only(top: NSizes.sm, left: NSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NProductTitleText(title: 'Green Nike Half Sleeves Shirt', smallSize: true),
                      SizedBox(height: NSizes.spaceBtwItems / 2),
                      NBrandTitleText(title: 'Nike'),
                    ],
                  ),
                  Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: NProductPriceText(price: '210.6')),
                      Container(
                        decoration: BoxDecoration(
                          color:NColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(NSizes.cardRadiusMd),
                            bottomRight: Radius.circular(NSizes.productImageRadius),
                          )
                        ),
                        child: SizedBox(
                          width: NSizes.iconLg * 1.2,
                          height: NSizes.iconLg * 1.2,
                          child: Center(child: const Icon(Iconsax.add, color: NColors.white))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
        );
  }
}
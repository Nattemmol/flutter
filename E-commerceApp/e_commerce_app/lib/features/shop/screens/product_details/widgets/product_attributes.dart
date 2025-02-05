import 'package:e_commerce_app/common/widgets/chips/choice_chips.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        NRoundedContainer(
          padding: const EdgeInsets.all(NSizes.md),
          backgroundColor: dark ? NColors.darkerGrey: NColors.grey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NSectionHeading(title: "Variation", showActionButton: false,),
                  const SizedBox(width: NSizes.spaceBtwItems / 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                    children: [
                      const NProductTitleText(title: 'Price : ', smallSize: true),
                      Text(
                        '\$25', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(width: NSizes.spaceBtwItems / 1.5),
                      const NProductPriceText(price: '20'),
                    ],
                  ),
                  Row(
                    children: [
                      const NProductTitleText(title: 'Stock : ', smallSize: true),
                      Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                    ],
                  ),
                ],
              ),

              NProductTitleText(
                title: "This is the Description of the Product and it can go upto max 4 lines",
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: NSizes.spaceBtwItems),
        Column(
          children: [
            const NSectionHeading(title: 'Colors'),
            const SizedBox(height: NSizes.spaceBtwItems /2,),
            Wrap(
              spacing: 8,
              children: [
                NChoiceChip(text: 'Green', selected: true, onSelected: (value) {}),
                NChoiceChip(text: 'Blue', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'yellow', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'Green', selected: true, onSelected: (value) {}),
                NChoiceChip(text: 'Blue', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'yellow', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'Green', selected: true, onSelected: (value) {}),
                NChoiceChip(text: 'Blue', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'yellow', selected: false, onSelected: (value) {}),
              ],
            )
            ],
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NSectionHeading(title: 'Size'),
            SizedBox(height: NSizes.spaceBtwItems /2,),
            Wrap(
              spacing: 8,
              children: [
                NChoiceChip(text: 'EU 34', selected: true, onSelected: (value) {}),
                NChoiceChip(text: 'EU 40', selected: false, onSelected: (value) {}),
                NChoiceChip(text: 'EU 44', selected: false, onSelected: (value) {}),
              ],
            )
            ],
        ),
      ],
    );

  }
}
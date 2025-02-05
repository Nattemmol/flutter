import 'package:e_commerce_app/common/widgets/brand/brand_show_case.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';


class NCategoryTab extends StatelessWidget {
  const NCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [Padding(
        padding: const EdgeInsets.all(NSizes.defaultSpace),
        child: Column(
          children: [
            NBrandShowCase(images: [NImages.productImage3,NImages.productImage2,NImages.productImage1],),
            NBrandShowCase(images: [NImages.productImage3,NImages.productImage2,NImages.productImage1],),
            const SizedBox(height: NSizes.spaceBtwItems),

            NSectionHeading(title: 'You might like', onPressed: () {},),
            const SizedBox(height: NSizes.spaceBtwItems),

            NGridLayout(
              itemCount: 4,
            itemBuilder: (_, index) => const NProductCardVertical()),
          const SizedBox(height: NSizes.spaceBtwItems),
          ],

        ),
      ),
      ],
    );
  }
}

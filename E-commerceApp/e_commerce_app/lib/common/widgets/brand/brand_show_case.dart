import 'package:e_commerce_app/common/widgets/brand/n_brand_card.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';


class NBrandShowCase extends StatelessWidget {
  const NBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return NRoundedContainer(
      showBorder: true,
      borderColor: NColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: NSizes.spaceBtwItems),
      child: Column(
        children: [
          const NBrandCard(showBorder: false),
          const SizedBox(height: NSizes.spaceBtwItems),
          Row(
            children: images.map((image) => brandTopProductImageWidget(image, context)).toList())
        ],
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded
  (
    child: NRoundedContainer(
      height: 100,
      padding: const EdgeInsets.all(NSizes.md),
      margin: const EdgeInsets.only(right: NSizes.sm),
      backgroundColor: NHelperFunctions.isDarkMode(context) ? NColors.darkerGrey: NColors.light,
      child: Image(fit: BoxFit.contain, image: AssetImage(image)),
    ),
  );
}


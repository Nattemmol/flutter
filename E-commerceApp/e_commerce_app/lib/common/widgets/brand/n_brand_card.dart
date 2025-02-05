import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/images/n_circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/n_brand_title_text_with_verified_icon.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NBrandCard extends StatelessWidget {
  const NBrandCard({
    super.key,
  required this.showBorder,
  this.onTap});

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NRoundedContainer(
          padding: const EdgeInsets.all(NSizes.sm),
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          child: Row(
            children: [
              Flexible(
                child: NCircularImage(
                  isNetworkImage: false,
                  image: NImages.clothIcon,
                  backgroundColor: Colors.transparent,
                  overlayColor: NHelperFunctions.isDarkMode(context)
                      ? NColors.white
                      : NColors.black,
                ),
              ),
              const SizedBox(width: NSizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const NBrandTitleWithVerifiedIcon(
                      title: "Nike",
                      brandTextSize: TextSizes.large,
                    ),
                    Text('256 products with',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

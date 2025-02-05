import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/common/widgets/texts/n_brand_title_text_with_verified_icon.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';



class NCartItem extends StatelessWidget {
  const NCartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      NRoundedImage(
        imageUrl: NImages.productImage1,
        width: 40,
        height: 60,
        padding: const EdgeInsets.all(NSizes.sm),
        backgroundColor: NHelperFunctions.isDarkMode(context) ? NColors.darkerGrey : NColors. light,
        ),
    
        const SizedBox(height: NSizes.spaceBtwItems,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NBrandTitleWithVerifiedIcon(title: 'Nike'),
                                Flexible(
                                  child: NProductTitleText(title: 'Black Sports shoes', maxLines: 1,),
                                )
                                ,
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                                      TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
                                      TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                                      TextSpan(text: 'UK 08 ', style: Theme.of(context).textTheme.bodyLarge),
                                    ]
                                  ),
                                )
                              ],
                            ),
                          ),
    ],);
  }
}
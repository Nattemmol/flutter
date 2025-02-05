import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NProductImageSlider extends StatelessWidget {
  const NProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return NCurvedEdgeWidget(
      child: Container(
        color: dark ? NColors.darkerGrey : NColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(NSizes.productImageRadius),
                  child: Center(
                      child: Image(image: AssetImage(NImages.productImage1))),
                )),
            Positioned(
              right: 0,
              bottom: 30,
              left: NSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    width: NSizes.spaceBtwItems,
                  ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return NRoundedImage(
                        width: 80,
                        backgroundColor: dark ? NColors.dark : NColors.white,
                        border: Border.all(color: NColors.primary),
                        padding: const EdgeInsets.all(NSizes.sm),
                        imageUrl: NImages.productImage3);
                  },
                ),
              ),
            ),
            NAppBar(
              showBackArrow: true,
              actions: [
                NCircularIcon(
                  icon: Iconsax.heart5,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

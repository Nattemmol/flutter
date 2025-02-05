import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/features/shop/controllers/home_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NPromoSlider extends StatelessWidget {
  const NPromoSlider({
    super.key, required this.banners,
  });
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: [
            banners.map((url) => NRoundedImage(imageUrl: NImages.promoBanner1)).toList()
          ],
        ),
        const SizedBox(height: NSizes.spaceBtwItems),
        Center(
          child: Obx(() => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < banners.length; i++)
                    NCircularContainer(
                        width: 20,
                        height: 4,
                        backgroundColor:
                            controller.carouselCurrentIndex.value == i
                                ? NColors.primary
                                : NColors.grey,
                        margin: EdgeInsets.only(right: 10)),
                ],
              )),
        ),
      ],
    );
  }
}

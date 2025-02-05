import 'package:e_commerce_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/authentication/screen/home/widgets/home_appbar.dart';
import 'package:e_commerce_app/features/authentication/screen/home/widgets/home_categories.dart';
import 'package:e_commerce_app/features/authentication/screen/home/widgets/promo_slider.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NPrimaryHeaderContainer(
              child: Column(
                children: [
                  NHomeAppBar(),
                  const SizedBox(height: NSizes.spaceBtwSections),
                  NSearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(height: NSizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: NSizes.defaultSpace),
                    child: Column(
                      children: [
                        
                        NHomeCategories(),
                        SizedBox(height: NSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(NSizes.defaultSpace),
                child: Column(
                  children: [
                    NPromoSlider(banners: [NImages.promoBanner1, NImages.promoBanner2, NImages.promoBanner3]),
                    SizedBox(height: NSizes.spaceBtwSections),

                    NSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                          onPressed: () => Get.to(() => const AllProducts()),
                        ),
                        SizedBox(height: NSizes.spaceBtwItems),
                        
                    NGridLayout(itemCount: 2, itemBuilder: (_ ,index) => const NProductCardVertical(),),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

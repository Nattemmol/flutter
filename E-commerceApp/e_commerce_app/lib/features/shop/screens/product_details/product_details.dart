import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:e_commerce_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: NBottomAddToCart(),
      appBar: AppBar(
        title: const Text('ProductDetails'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NProductImageSlider(),
            Padding(
              padding: EdgeInsets.only(right:NSizes.defaultSpace,left: NSizes.defaultSpace, bottom: NSizes.defaultSpace),
              child: Column(
                children: [
                  NRatingAndShare(),
                  NProductMetaData(),
                  ProductAttributes(),
                  SizedBox(height: NSizes.spaceBtwSections),

                  SizedBox(width:double.infinity, child: ElevatedButton(onPressed: () {}, child: Text('Checkout'))),
                  const NSectionHeading(title: 'Description', showActionButton: false,),
                  const SizedBox(height: NSizes.spaceBtwItems),
                  const ReadMoreText(
                    "this is Nati's E-commerce app",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: NSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NSectionHeading(title: 'Reviews(199),',showActionButton: false,),
                      IconButton(onPressed: ()=> Get.to(()=> const ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18)),
                    ],
                  ),
                  const SizedBox(height: NSizes.spaceBtwSections),
                ],
              ),
              ),
          ],
        ),
      ),
    );
  }
}

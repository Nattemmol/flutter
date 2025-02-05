import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/images/n_rounded_image.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_card_horizontal.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';


class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NAppBar(title: Text('Sports shirts'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NSizes.defaultSpace),
          child: Column(
            children: [
              NRoundedImage(
                width: double.infinity, imageUrl: NImages.promoBanner4, applyImageRadius: true,
              ),
              SizedBox(height: NSizes.spaceBtwSections,),
              Column(
                children: [
                  NSectionHeading(title: 'Sports Shirts', onPressed: () {},),
                  
              SizedBox(height: NSizes.spaceBtwItems / 2),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context,index) => const SizedBox(width: NSizes.spaceBtwItems,),
                  itemBuilder: (context, index) => const NProductCardHorizontal()),
              ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
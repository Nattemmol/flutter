import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/brand/n_brand_card.dart';
import 'package:e_commerce_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NAppBar(title: Text('Nike')),
      body: Padding(
        padding: EdgeInsets.all(NSizes.defaultSpace),
        child: Column(
          children: [
            NBrandCard(showBorder: true),
            SizedBox(height: NSizes.spaceBtwSections),

            NSortableProducts(),
          ],
        ),
        ),
    );
  }
}
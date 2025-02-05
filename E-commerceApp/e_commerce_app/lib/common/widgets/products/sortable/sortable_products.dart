import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class NSortableProducts extends StatelessWidget {
  const NSortableProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity'].map((option) => DropdownMenuItem(
            value: option,
            child: Text(option))).toList(),
          onChanged: (value) {}
          ),
    
          const SizedBox(height: NSizes.spaceBtwSections,),
    
          NGridLayout(
            itemCount: 4,
            itemBuilder: (_, index) => NProductCardVertical(),
            ),
      ],
    );
  }
}
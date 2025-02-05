import 'package:e_commerce_app/common/widgets/products/Product_cards/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/products/cart/add_remove_button.dart';
import 'package:e_commerce_app/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NCartItems extends StatelessWidget {
  const NCartItems({
    super.key,
  this.showAddRemoveButtons = true,
  });
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          shrinkWrap: true,
          itemCount: 10,
          separatorBuilder: (_, __) => const SizedBox(height: NSizes.spaceBtwSections),
          itemBuilder: (_, index) => Column(
            children: [
              NCartItem(),
              if(showAddRemoveButtons) const SizedBox(height: NSizes.spaceBtwSections,),
              
              if(showAddRemoveButtons)
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width:70,),
                  NProductQuantityWithRemoveButton(),
                  ],
                ),
                  NProductPriceText(price: '299'),
              ],
              ),
          ],
          ),
          );
  }
}
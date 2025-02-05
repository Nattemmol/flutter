import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/products/cart/add_remove_button.dart';
import 'package:e_commerce_app/common/widgets/products/cart/cart_item.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NAppBar(showBackArrow: true,title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),

      body: Padding(
        padding: const EdgeInsets.all(NSizes.defaultSpace),
        child: NCartItems(),
        ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(NSizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(() => const CheckoutScreen()), child: Text("Checkout $256.0")),
      ),
    );
  }
}

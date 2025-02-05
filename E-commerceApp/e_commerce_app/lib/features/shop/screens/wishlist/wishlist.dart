import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/icons/n_circular_icon.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/Product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/features/authentication/screen/home/home.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: NAppBar(
      title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
      actions: [
        NCircularIcon( icon: Iconsax.add, dark: true,onPressed: () => Get.to(() => const HomeScreen()),),
      ],
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(NSizes.defaultSpace),
        child: Column(
          children: [
            NGridLayout(itemCount: 6,
            itemBuilder: (_,index)=> const NProductCardVertical(),
            ),
        ],
        ),
      ),
    ),
    );
  }
}

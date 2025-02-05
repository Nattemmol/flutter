import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/products/cart/coupon_widget.dart';
import 'package:e_commerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: NAppBar(showBackArrow: true,title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(NSizes.defaultSpace),
          child: Column(
            children: [
              const NCartItems(showAddRemoveButtons: false,),
              SizedBox(height: NSizes.spaceBtwSections,),

              NCouponCode(),
              SizedBox(height: NSizes.spaceBtwSections),

              NRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(NSizes.md),
                backgroundColor: dark? NColors.black: NColors.white,
                child: Column(
                  children: [
                    NBillingAmountSection(),
                    const SizedBox(height: NSizes.spaceBtwInputFields,),

                    const Divider(),
                    const SizedBox(height: NSizes.spaceBtwItems,),

                    const Divider(),
                    const SizedBox(height: NSizes.spaceBtwItems,),

                    NBillingPaymentSection(),
                    const SizedBox(height: NSizes.spaceBtwItems / 2,),

                    NBillingAddressSection(),
                  ],
                ),
              ),
          ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(NSizes.defaultSpace),
        child: ElevatedButton(onPressed: ()=> Get.to(()
        => SuccessScreen(
          image: NImages.successfulPaymentIcon,
          title: 'Payment Success',
          subTitle: 'Thank you, Your item will be shipped soon!',
        onPressed: () => Get.offAll(()=> const NavigationMenu()),
        )),
        child: Text("Checkout \$256.0")),
      ),
    );
  }
}

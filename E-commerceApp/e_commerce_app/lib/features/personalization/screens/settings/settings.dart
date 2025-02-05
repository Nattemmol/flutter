import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_commerce_app/features/personalization/screens/address/address.dart';
import 'package:e_commerce_app/features/shop/screens/order/order.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/common/widgets/list_tiles/user_profile_tile.dart';
import '/common/widgets/texts/section_heading.dart';
import '/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NPrimaryHeaderContainer(
              child: Column(children: [
                NAppBar(
                  title: Text('Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: NColors.white,
                          )),
                ),
                NUserProfileTile(onPressed: ()=> Get.to(() => const ProfileScreen())),
                const SizedBox(height: NSizes.spaceBtwSections),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(NSizes.defaultSpace),
              child: Column(
                children: [
                  NSectionHeading(title: 'Account Settings', showActionButton: false,),
                  SizedBox(height: NSizes.spaceBtwItems),
                  NSettingsMenuTile(icon: Iconsax.safe_home,title: 'My Addresses',subTitle: 'Set shopping delivery address',onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  NSettingsMenuTile(icon: Iconsax.shopping_cart,title: 'My Cart',subTitle: 'add, remove products and move to checkout',onTap: () {},
                  ),
                  NSettingsMenuTile(icon: Iconsax.bag_tick,title: 'My Orders',subTitle: 'In-progress and Completed Orders',onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  NSettingsMenuTile(icon: Iconsax.bank,title: 'My Account',subTitle: 'Withdraw balance to registered bank account',onTap: () {},
                  ),
                  NSettingsMenuTile(icon: Iconsax.discount_shape,title: 'My Coupons',subTitle: 'List of all the discounted coupons',onTap: () {},
                  ),
                  NSettingsMenuTile(icon: Iconsax.notification,title: 'Notifications',subTitle: 'Set any kind of notification message',onTap: () {},
                  ),
                  NSettingsMenuTile(icon: Iconsax.security_card,title: 'Account Primacy',subTitle: 'Manage data usage and connected accounts',onTap: () {},
                  ),

                  SizedBox(height: NSizes.spaceBtwSections),
                  NSectionHeading(title: "App Settings", showActionButton: false,),
                  SizedBox(height: NSizes.spaceBtwItems,),
                  NSettingsMenuTile(icon: Iconsax.document_upload,title: 'Load Data',subTitle: 'upload data to your Cloud firebase',
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    onTap: () {},
                    trailing: Switch(value: true, onChanged:(value) {}),
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    onTap: () {},
                    trailing: Switch(value: false, onChanged:(value) {}),
                  ),
                  NSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image Quality',
                    subTitle: 'Set image quality to be seen',
                    onTap: () {},
                    trailing: Switch(value: false, onChanged:(value) {}),
                  ),
                  const SizedBox(height: NSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () {}, child: const Text('Logout')),
                  ),
                  const SizedBox(height: NSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

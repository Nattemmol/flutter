import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/images/n_circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '/features/personalization/screens/profile/widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NSizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    NCircularImage(image: NImages.user, width: 80, height: 80),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile picture'))
                  ],
                ),
              ),
              const SizedBox(height: NSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: NSizes.spaceBtwItems),
              const NSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: NSizes.spaceBtwItems / 2),
              NProfileMenu(title: 'Name', value: 'Natnael Temesegen', onPressed: () {}),
              NProfileMenu(title: 'UserName', value: 'Eric Cantona', onPressed: () {}),

              const SizedBox(height: NSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: NSizes.spaceBtwItems),

              const NSectionHeading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: NSizes.spaceBtwItems),

              NProfileMenu(title: 'User ID', value: 'ETS 1240/14', icon:Iconsax.copy, onPressed: () {}),
              NProfileMenu(title: 'E-mail', value: 'nattemmol@gmail.com', onPressed: () {}),
              NProfileMenu(title: 'Phone Number', value: '0963572327', onPressed: () {}),
              NProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              NProfileMenu(title: 'Date of Birth', value: '20 July, 2003', onPressed: () {}),

              const Divider(),
              const SizedBox(height: NSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Cloth Account', style: TextStyle(color: Colors.red)),
                  ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

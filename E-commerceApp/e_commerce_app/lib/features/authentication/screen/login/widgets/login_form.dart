import 'package:e_commerce_app/features/authentication/screen/password_configuration/forgot_password.dart';
import 'package:e_commerce_app/features/authentication/screen/signup/signup.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NLoginForm extends StatelessWidget {
  const NLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical:NSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: NTexts.email,
              ),
          ),
          const SizedBox(height: NSizes.spaceBtwInputFields),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: NTexts.password,
              suffixIcon: Icon(Iconsax.eye_slash),
              ),
          ),
          const SizedBox(height: NSizes.spaceBtwInputFields/2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value){}),
                  const Text(NTexts.rememberMe),
              ],
              ),
              TextButton(
                onPressed: () => Get.to(() => const ForgotPassword()),
              child: const Text(NTexts.forgotPassword),
              ),
            ],
          ),
          const SizedBox(height: NSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(() => const NavigationMenu()),
            child: Text(NTexts.signIn),
            ),
          ),
          SizedBox(height: NSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.to(() => const SignUpScreen()),
            child: Text(NTexts.createAccount),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

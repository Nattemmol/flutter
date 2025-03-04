import 'package:e_commerce_app/features/authentication/screen/password_configuration/reset_password.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding: EdgeInsets.all(NSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(NTexts.forgotPassword, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: NSizes.spaceBtwItems),
            Text(NTexts.forgotPasswordTitle, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: NSizes.spaceBtwSections * 2),

            TextFormField(
              decoration: InputDecoration(
                labelText: NTexts.email,
                prefixIcon: Icon(Iconsax.direct_right)),
            ),
            SizedBox(width: NSizes.spaceBtwSections),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.off(() => const ResetPassword()),
              child: const Text(NTexts.nContinue),))
          ],
          ),
        ),
    );
  }
}
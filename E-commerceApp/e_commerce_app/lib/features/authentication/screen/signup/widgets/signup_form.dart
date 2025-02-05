import 'package:e_commerce_app/features/authentication/screen/signup/verify_email.dart';
import 'package:e_commerce_app/features/authentication/screen/signup/widgets/terms_conditions_checkbox.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NSignupForm extends StatelessWidget {
  const NSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NHelperFunctions.isDarkMode(context);
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: NTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    )),
              ),
              const SizedBox(width: NSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: NTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    )),
              ),
            ],
          ),
          const SizedBox(height: NSizes.spaceBtwInputFields),
          TextFormField(
              expands: false,
              decoration: const InputDecoration(
                labelText: NTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit),
              )),
          const SizedBox(height: NSizes.spaceBtwInputFields),
          TextFormField(
              expands: false,
              decoration: const InputDecoration(
                labelText: NTexts.email,
                prefixIcon: Icon(Iconsax.direct),
              )),
          const SizedBox(height: NSizes.spaceBtwInputFields),
          TextFormField(
              expands: false,
              decoration: const InputDecoration(
                labelText: NTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call),
              )),
          const SizedBox(height: NSizes.spaceBtwInputFields),
          TextFormField(
              obscureText: true,
              expands: false,
              decoration: const InputDecoration(
                labelText: NTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash),
              )),
          const SizedBox(height: NSizes.spaceBtwSections),
          const NTermsAndConditionsCheckbox(),
          const SizedBox(height: NSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>Get.to(()=>const VerifyEmailScreen()),
              child: const Text(NTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}



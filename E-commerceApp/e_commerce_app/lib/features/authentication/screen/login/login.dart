import 'package:e_commerce_app/common/styles/spacing_styles.dart';
import 'package:e_commerce_app/features/authentication/screen/login/widgets/login_form.dart';
import 'package:e_commerce_app/features/authentication/screen/login/widgets/login_header.dart';
import 'package:e_commerce_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce_app/common/widgets/login_signup/social_buttons.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: NSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            NLoginHeader(dark: dark),
            const NLoginForm(),
            NFormDivider(dark: dark, dividerText: NTexts.orSignInWith,),
              const SizedBox(width: NSizes.spaceBtwSections),
            const NSocialButtons(),
          ],
        ),
      ),
    ));
  }
}





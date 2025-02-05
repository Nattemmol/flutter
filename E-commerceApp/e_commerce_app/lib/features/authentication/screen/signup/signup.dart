import 'package:e_commerce_app/common/widgets/login_signup/form_divider.dart';
import 'package:e_commerce_app/common/widgets/login_signup/social_buttons.dart';
import 'package:e_commerce_app/features/authentication/screen/signup/widgets/signup_form.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(NSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(NTexts.signUpTitle, style: Theme.of(context).textTheme.headlineMedium),
              NSignupForm(),
                const SizedBox(height: NSizes.spaceBtwSections),
                    
                NFormDivider(dark: dark, dividerText: NTexts.orSignInWith),
               const SizedBox(height: NSizes.spaceBtwSections),
               const  NSocialButtons(),
            ],
            ),
        ),
      ),
    );
  }
}


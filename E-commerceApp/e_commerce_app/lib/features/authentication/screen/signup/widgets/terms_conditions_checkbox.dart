import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';


class NTermsAndConditionsCheckbox extends StatelessWidget {
  const NTermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(width: NSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${NTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${NTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? NColors.white : NColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? NColors.white : NColors.primary,
                    )),
            TextSpan(
                text: NTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: NTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? NColors.white : NColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? NColors.white : NColors.primary,
                    )),
          ]),
        ),
      ],
    );
  }
}
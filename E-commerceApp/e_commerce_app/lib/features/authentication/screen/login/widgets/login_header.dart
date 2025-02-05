import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class NLoginHeader extends StatelessWidget {
  const NLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark? NImages.lightAppLogo: NImages.darkAppLogo),
        ),
        Text(NTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: NSizes.sm),
        Text(NTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium)
        
      ],
    );
  }
}

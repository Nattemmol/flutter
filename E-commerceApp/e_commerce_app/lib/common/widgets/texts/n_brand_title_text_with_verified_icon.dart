import 'package:e_commerce_app/common/widgets/texts/n_brand_title_text.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NBrandTitleWithVerifiedIcon extends StatelessWidget {
  const NBrandTitleWithVerifiedIcon({super.key,
  required this.title,
  this.maxLines = 1,
  this.textColor,
  this.iconColor = NColors.primary,
  this.textAlign = TextAlign.center,
  this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: NBrandTitleText(
            title: title,
            textColor: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
        ),
        ),
        const SizedBox(width: NSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: NSizes.iconXs),
      ],
    );

  }
}

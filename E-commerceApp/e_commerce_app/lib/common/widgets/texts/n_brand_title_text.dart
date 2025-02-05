import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NBrandTitleText extends StatelessWidget {
  const NBrandTitleText({
    super.key,
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
      children: [
        Text(title,
        textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: brandTextSize == TextSizes.small ?
            Theme.of(context).textTheme.labelMedium!.apply(color: textColor):
            brandTextSize == TextSizes.medius ?
            Theme.of(context).textTheme.bodyLarge!.apply(color:textColor)
            : brandTextSize == TextSizes.large ?
            Theme.of(context).textTheme.titleLarge!.apply(color:textColor):
            Theme.of(context).textTheme.bodyMedium!.apply(color: textColor)),
        const SizedBox(height: NSizes.xs),
        const Icon(Iconsax.verify5,
            color: NColors.primary, size: NSizes.iconXs),
      ],
    );
  }
}

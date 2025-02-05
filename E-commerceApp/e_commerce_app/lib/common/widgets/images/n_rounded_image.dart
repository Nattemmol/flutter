import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';



class NRoundedImage extends StatelessWidget {
  const NRoundedImage({
    super.key,
    this.width = 150,
    this.height = 150,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = NSizes.md,
  });
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: applyImageRadius? BorderRadius.circular(borderRadius): BorderRadius.zero,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(NSizes.md),
            child: Image(
              fit: fit,
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
            )),
      ),
    );
  }
}

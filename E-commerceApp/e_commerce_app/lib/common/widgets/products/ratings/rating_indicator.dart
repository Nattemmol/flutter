import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class NRatingBarIndicator extends StatelessWidget {
  const NRatingBarIndicator({
    super.key,
  required this.rating, required Null Function(BuildContext context, int index) itemBuilder
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 20,
        unratedColor: NColors.grey,
        itemBuilder: (_, __) =>
            const Icon(Iconsax.star1, color: NColors.primary));
  }
}

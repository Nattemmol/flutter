import 'package:e_commerce_app/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';


class NOverallProductRating extends StatelessWidget {
  const NOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text('4.0',
              style: Theme.of(context).textTheme.displayLarge),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              NRatingProgressIndicator(text: '5', value: 0.5),
              NRatingProgressIndicator(text: '4', value: 0.4),
              NRatingProgressIndicator(text: '3', value: 0.3),
              NRatingProgressIndicator(text: '2', value: 0.2),
              NRatingProgressIndicator(text: '1', value: 0.1),
            ],
          ),
        ),
      ],
    );
  }
}

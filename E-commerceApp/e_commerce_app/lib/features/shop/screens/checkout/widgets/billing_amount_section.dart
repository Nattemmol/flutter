import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NBillingAmountSection extends StatelessWidget {
  const NBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$123.6', style: Theme.of(context).textTheme.bodyMedium),

          ],
        ),
        SizedBox(height: NSizes.spaceBtwItems / 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shopping Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$12.0', style: Theme.of(context).textTheme.labelLarge),

          ],
        ),

      SizedBox(height: NSizes.spaceBtwItems / 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tax Fee', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$5.0', style: Theme.of(context).textTheme.labelLarge),

          ],
        ),
        SizedBox(height: NSizes.spaceBtwItems / 2),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Order total', style: Theme.of(context).textTheme.bodyMedium),
            Text('\$21.0', style: Theme.of(context).textTheme.titleMedium),

          ],
        ),

          ],
        );
  }
}
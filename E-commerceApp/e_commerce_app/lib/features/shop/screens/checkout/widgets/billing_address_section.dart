import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class NBillingAddressSection extends StatelessWidget {
  const NBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NSectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () {},),
        Text('Code With Nati', style: Theme.of(context).textTheme.bodyLarge,),
        const SizedBox(height: NSizes.spaceBtwItems / 2,),

        Row(
          children: [
          const Icon(Icons.phone, color: Colors.grey, size: 16),
          const SizedBox(width: NSizes.spaceBtwItems,),
          Text('+251-963-572-327', style: Theme.of(context).textTheme.bodyMedium),
        ],
        ),
        const SizedBox(width: NSizes.spaceBtwItems,),
        Row(
          children: [
          const Icon(Icons.location_history, color: Colors.grey, size: 16),
          const SizedBox(width: NSizes.spaceBtwItems,),
          Expanded(
            child: Text('Killinto, Addis Ababa, Ethiopia', style: Theme.of(context).textTheme.bodyMedium,softWrap: true,),
          )
          ,
        ],
        ),
        const SizedBox(width: NSizes.spaceBtwItems,),
        
      ],
    );
  }
}
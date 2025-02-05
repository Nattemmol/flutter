import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NBillingPaymentSection extends StatelessWidget {
  const NBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        NSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {},),
        const SizedBox(height: NSizes.spaceBtwItems / 2,),

        Row(children: [

          NRoundedContainer(
            width: 60,
            height: 35,
            backgroundColor: dark ? NColors.light: NColors.white,
            padding: const EdgeInsets.all(NSizes.sm),
            child: Image(image: AssetImage(NImages.paypal), fit: BoxFit.contain),
          ),
          const SizedBox(width: NSizes.spaceBtwItems /2),
          Text('Paypal',style: Theme.of(context).textTheme.bodyLarge),
          
        ],
        ),
      ],
    );
  }
}
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class NOrderListItems extends StatelessWidget {
  const NOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(height: NSizes.spaceBtwItems,),
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder:(_, index) => NRoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(NSizes.md),
        backgroundColor: dark? NColors.dark: NColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Iconsax.ship),
                SizedBox(width: NSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Processing',
                          style: Theme.of(context).textTheme.bodyLarge!.apply(color: NColors.primary, fontWeightDelta: 1),
                          ),
                          Text('20 July 2024', style: Theme.of(context).textTheme.headlineSmall,),
                        ],
                      ),
            ),
            IconButton(onPressed: onPressed, icon: const Icon(Iconsax.arrow_right_34, size: NSizes.iconSm,)),
              ],
            ),
      
            const SizedBox(height: NSizes.spaceBtwItems / 2,),
      
            
            Row(
              children: [
                Expanded(
                  child: Row(
                                children: [
                                  Icon(Iconsax.tag),
                                  SizedBox(width: NSizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Order',
                                            style: Theme.of(context).textTheme.labelMedium),
                                            Text('[#202024]', style: Theme.of(context).textTheme.titleMedium,),
                                          ],
                                        ),
                              ),
                                ],
                              ),
                ),
      
                Expanded(
                  child: Row(
                                children: [
                                  Icon(Iconsax.calendar),
                                  SizedBox(width: NSizes.spaceBtwItems / 2),
                              Expanded(
                                child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Shopping Date',
                                            style: Theme.of(context).textTheme.labelMedium),
                                            Text('0 july 2025', style: Theme.of(context).textTheme.titleMedium,),
                                          ],
                                        ),
                              ),
                                ],
                              ),
                ),
              ],
            ),
            ],
        ),
      ),
      );
  }
}
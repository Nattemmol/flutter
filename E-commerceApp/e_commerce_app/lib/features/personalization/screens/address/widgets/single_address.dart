import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NSingleAddress extends StatelessWidget {
  const NSingleAddress({
    super.key,
    required this.selectedAddress,
    });

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return NRoundedContainer(
                width: double.infinity,
                showBorder: true,
                padding: const EdgeInsets.all(NSizes.md),
                backgroundColor: selectedAddress? NColors.primary.withOpacity(0.5): Colors.transparent,
                borderColor: selectedAddress? Colors.transparent : dark ?
                NColors.darkerGrey:
                NColors.grey,
                margin: const EdgeInsets.only(bottom: NSizes.spaceBtwItems),
                child: Stack(
                  children: [
                    Positioned(
                      right: 5,
                      top: 0,
                      child: Icon(
                                selectedAddress ? Iconsax.tick_circle5: null,
                                color: selectedAddress? dark ?
                                NColors.light :
                                NColors.dark.withOpacity(0.2) : null,
                      ),
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text ('Natty Tem',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: NSizes.sm / 2),
                        const Text('(+251) 963 572 327', maxLines: 1, overflow: TextOverflow.ellipsis,),
                        const SizedBox(height: NSizes.sm / 2,),
                        const Text('Natty Temesegen', softWrap: true,),
                        
                      ],
                    )
                  ],
                ),
              );
  }
}
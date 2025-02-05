import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/products/ratings/rating_indicator.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = NHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(NImages.userProfileImage1),),
                const SizedBox(width: NSizes.spaceBtwItems,),
                Text('Natty Tem', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(icon:const Icon(Icons.more_vert), onPressed: () {  },),
          ],
        ),
        const SizedBox(width: NSizes.spaceBtwItems,),

        Row(
          children: [
            NRatingBarIndicator(rating: 4),
            const SizedBox(width: NSizes.spaceBtwItems,),
            Text('10 Dec, 2021', style: Theme.of(context).textTheme.bodyMedium),
        ],
        ),
        const SizedBox(height: NSizes.spaceBtwItems,),
        ReadMoreText(
          'ewiuopkljcgfxzdcgv,m.dfs',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText : ' Show less',
          trimCollapsedText : ' Show more',
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: NColors.primary),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: NColors.primary),
          ),

          const SizedBox(height:NSizes.spaceBtwItems,),
          NRoundedContainer(
            backgroundColor: dark? NColors.darkerGrey: NColors.grey,
            child: Padding(
              padding: EdgeInsets.all(NSizes.md),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text("N's Store", style: Theme.of(context).textTheme.titleMedium),
                      Text("20 July, 2021", style: Theme.of(context).textTheme.bodyMedium),
                  ]
                  ),

                  const SizedBox(height: NSizes.spaceBtwItems,),
        ReadMoreText(
          'ewiuopkljcgfxzdcgv,m.dfs',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText : ' Show less',
          trimCollapsedText : ' Show more',
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: NColors.primary),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: NColors.primary),
          ),
                ],
              ),
              ),
          ),
          const SizedBox(height: NSizes.spaceBtwSections,),
      ],
    );
  }
}

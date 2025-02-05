import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '/common/widgets/images/n_circular_image.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/colors.dart';

class NUserProfileTile extends StatelessWidget {
  const NUserProfileTile({
    super.key, required Function() onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: NCircularImage(
        image: NImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text('Nattemmol',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: NColors.white)),
      subtitle: Text('nattemmol@gmail.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: NColors.white)),
      trailing: IconButton(
          onPressed: () {}, icon: Icon(Iconsax.edit, color: NColors.white)),
    );
  }
}

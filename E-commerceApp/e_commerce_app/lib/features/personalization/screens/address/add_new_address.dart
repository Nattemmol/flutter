import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(NSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name')),
                  SizedBox(height: NSizes.spaceBtwInputFields),
                TextFormField(
                  decoration: InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: 'Phone Number')),
                  SizedBox(height: NSizes.spaceBtwInputFields),
                Row(
                  children: [
                  Expanded(
                    child: TextFormField(
                                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: 'Street')),
                  ),
                  const SizedBox(height: NSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: 'Postal Code')),
                  ),
                ],
                ),
                const SizedBox(height: NSizes.spaceBtwInputFields),
                Row(
                  children: [
                  Expanded(
                    child: TextFormField(
                                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: 'City')),
                  ),
                  const SizedBox(height: NSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                                    decoration: InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: 'State')),
                  ),
                ],
                ),
                const SizedBox(height: NSizes.spaceBtwInputFields),
                TextFormField(decoration: InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: 'Country')),
                const SizedBox(height: NSizes.defaultSpace,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {},child: Text('Save'),))
              ],
            ),
            ),
          ),
      ),
    );
  }
}
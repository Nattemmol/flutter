import 'package:e_commerce_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper.dart';
import 'package:flutter/material.dart';

class NChoiceChip extends StatelessWidget {
  const NChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = NHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? NColors.white : null),
        avatar: isColor
            ? NCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: NHelperFunctions.getColor(text)!)
            : null,
        shape: isColor ? CircleBorder() : null,
        labelPadding:
            isColor ? EdgeInsets.all(0) : null,
        padding:
            isColor ? EdgeInsets.all(0) : null,
        selectedColor: Colors.green,
        backgroundColor: isColor? NHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}

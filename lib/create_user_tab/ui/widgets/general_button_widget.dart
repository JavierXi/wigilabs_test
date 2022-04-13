import 'package:flutter/material.dart';
import 'package:wigilabs/widgets/colors.dart' as color;

class GeneralButtonWidget extends StatelessWidget {
  final String label;
  final dynamic onPressed;
  const GeneralButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        elevation: 3,
        shadowColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 15,
        ),
        primary: color.AppColor.companyFucciaColor,
        onPrimary: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}

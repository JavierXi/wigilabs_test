import 'package:flutter/material.dart';
import 'package:wigilabs/widgets/colors.dart' as color;

class BuildFieldWidget extends StatefulWidget {
  final bool autofocus;
  final dynamic controller;
  final dynamic capitalization;
  final dynamic prefixIcon;
  final dynamic hintText;
  final dynamic validator;
  final dynamic keyboardType;
  final dynamic textInputAction;

  const BuildFieldWidget({
    Key? key,
    required this.autofocus,
    required this.controller,
    required this.capitalization,
    required this.prefixIcon,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.textInputAction,
  }) : super(key: key);

  @override
  _BuildFieldWidgetState createState() => _BuildFieldWidgetState();
}

class _BuildFieldWidgetState extends State<BuildFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      textCapitalization: widget.capitalization,
      decoration: InputDecoration(
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color.AppColor.companyFucciaColor,
            width: 1,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color.AppColor.companyFucciaColor,
            width: 1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color.AppColor.companyBlueColor,
            width: 1,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color.AppColor.companyBlueColor,
            width: 1,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: color.AppColor.companyBlueColor,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: color.AppColor.darkGrayColor.withOpacity(0.4),
        ),
        errorStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: color.AppColor.companyFucciaColor,
        ),
        border: const UnderlineInputBorder(),
      ),
      style: TextStyle(
        color: color.AppColor.darkGrayColor,
        fontSize: 15,
      ),
      cursorColor: color.AppColor.darkGrayColor,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }
}

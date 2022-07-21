import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';

class BaseTextFormField extends StatelessWidget {
  final String? labelText, hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  const BaseTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: TextFormField(
        validator: validator,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(labelText: labelText?.tr(), border: const OutlineInputBorder(), hintText: hintText?.tr()),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}

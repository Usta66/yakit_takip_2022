import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final String? labelText, hintText;
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String)? onChanged;

  final bool? readOnly;

  const BaseTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly!,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(labelText: labelText, border: const OutlineInputBorder(), hintText: hintText),
    );
  }
}

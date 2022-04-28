import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/components/left_icon_text.dart';

class YakitEklemeTextFormField extends StatelessWidget {
  const YakitEklemeTextFormField(
      {Key? key,
      required this.icon,
      required this.text,
      this.onChanged,
      this.keyboardType,
      this.suffixTex,
      required this.controller,
      this.validator,
      this.onTap,
      this.readOnly = false})
      : super(key: key);

  final IconData icon;
  final String text;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? suffixTex;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: LeftIconText(icon: icon, text: text)),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(suffixText: suffixTex),
            controller: controller,
            validator: validator,
            onTap: onTap,
            readOnly: readOnly,
          ),
        )
      ],
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocaleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LocaleText(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),
      style: style,
    );
  }
}

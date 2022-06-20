import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  final String? label;
  final BuildContext context;

  MyAppBar({required this.context, this.label, Key? key, super.centerTitle, super.actions})
      : super(
            key: key,
            title: Text(
              label?.tr() ?? "",
              style: Theme.of(context).textTheme.displaySmall,
            ));
}

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class MyAppBarActionButton extends StatelessWidget {
  const MyAppBarActionButton({Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.check),
        iconSize: context.mediumValue,
        color: Colors.amber,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LeftIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const LeftIconText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
        Text(
          text.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: const Color(0xFF66667A)),
        )
      ],
    );
  }
}

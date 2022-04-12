import 'package:flutter/material.dart';

class LeftIconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const LeftIconText({Key? key, required this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.headline6!.copyWith(color: Color(0xFF66667A)),
        )
      ],
    );
  }
}

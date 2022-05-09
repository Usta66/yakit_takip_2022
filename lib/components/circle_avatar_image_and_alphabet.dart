import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:kartal/kartal.dart';

class CircleAvatarImageAndAlphabet extends StatelessWidget {
  final Function()? onTap;

 final String? imagePath;
 final String? text;
 final  int? color;

final double radius;

  const CircleAvatarImageAndAlphabet(
      {Key? key,
      this.onTap,
      required this.radius,
      this.text,
      this.imagePath,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          backgroundImage:
              imagePath == null ? null : FileImage(File(imagePath!)),
          radius: radius,
          child: imagePath == null
              ? Padding(
                  padding: context.paddingLow,
                  child: Center(
                    child: AutoSizeText(
                      text != null ? text!.toUpperCase() : " ",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                )
              : null,
          backgroundColor: color!=null?Color(color!):null

          // Colors.primaries[Random().nextInt(17)],
          ),
    );
  }
}

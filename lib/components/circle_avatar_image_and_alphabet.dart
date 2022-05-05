import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../model/car_model.dart';

class CircleAvatarImageAndAlphabet extends StatelessWidget {
  Function()? onTap;

  String? imagePath;
  String? aracAdi;
  Color? color;

  late double radius;

  CircleAvatarImageAndAlphabet(
      {Key? key,
      this.onTap,
      required this.radius,
      this.aracAdi,
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
                      aracAdi != null ? aracAdi!.toUpperCase() : " ",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                )
              : null,
          backgroundColor: color

          // Colors.primaries[Random().nextInt(17)],
          ),
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/car_model.dart';

class CircleAvatarImageAndAlphabet extends StatelessWidget {
  Function()? onTap;

  String? imagePath;
  String? aracAdi;

  late double radius;

  CircleAvatarImageAndAlphabet({Key? key, this.onTap, required this.radius, this.aracAdi, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: imagePath == null ? null : FileImage(File(imagePath!)),
        radius: radius,
        child: imagePath == null
            ? Text(
                aracAdi != null ? aracAdi!.toUpperCase()[0] : " ",
                style: Theme.of(context).textTheme.headline4,
              )
            : null,
        backgroundColor: Colors.primaries[Random().nextInt(17)],
      ),
    );
  }
}

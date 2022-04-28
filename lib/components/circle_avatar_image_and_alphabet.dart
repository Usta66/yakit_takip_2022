import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../model/car_model.dart';

class CircleAvatarImageAndAlphabet extends StatelessWidget {
  Function()? onTap;

  final CarModel carModel;

  late double radius;

  CircleAvatarImageAndAlphabet({
    Key? key,
    this.onTap,
    required this.radius,
    required this.carModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: carModel.imagePath == null ? null : FileImage(File(carModel.imagePath!)),
        radius: radius,
        child: carModel.imagePath == null
            ? Text(
                carModel.adi != null ? carModel.adi!.toUpperCase()[0] : " ",
                style: Theme.of(context).textTheme.headline4,
              )
            : null,
        backgroundColor: Colors.primaries[Random().nextInt(17)],
      ),
    );
  }
}

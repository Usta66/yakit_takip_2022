import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullscreenImageView extends StatelessWidget {
  const FullscreenImageView({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: FileImage(file));
  }
}

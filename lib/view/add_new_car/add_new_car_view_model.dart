import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';

class AddNewCarViewModel extends ChangeNotifier {
  late CarModel carModel;
  late bool isNew;
  Color _color = Color(0xFFFF9000);

  set color(Color color) {
    _color = color;
    notifyListeners();
  }

  Color get color => _color;

  late TextEditingController controllerAdi,
      controllerYakitTuru,
      controllerLpgDepo,
      controllerAracDepo;

  final DatabaseService _dbServis = DatabaseService.instance!;

  File? image;

  final picker = ImagePicker();

  getImage(bool issourceGallery) async {
    final pickedFile = await picker.pickImage(
        source: issourceGallery ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      image = await _cropImage(image);
    }

    notifyListeners();
  }

  Future _cropImage(File? image) async {
    var croppedFile = await ImageCropper.platform
        .cropImage(sourcePath: image!.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      )
    ]);

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }

  AddNewCarViewModel.addNew() {
    isNew = true;
    carModel = CarModel();
    controllerAdi = TextEditingController()
      ..addListener(() {
        notifyListeners();
      });
    controllerYakitTuru = TextEditingController()
      ..addListener(() {
        notifyListeners();
      });
    controllerLpgDepo = TextEditingController();
    controllerAracDepo = TextEditingController();
  }
  AddNewCarViewModel.show({required this.carModel}) {
    isNew = false;
    controllerAdi = TextEditingController(text: carModel.adi);
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name);
    controllerLpgDepo =
        TextEditingController(text: carModel.aracLpgDepo.toString());
    controllerAracDepo =
        TextEditingController(text: carModel.aracDepo.toString());
    image = carModel.imagePath == null ? null : File(carModel.imagePath!);
  }

  CarModel modeliHazirla() {
    return carModel = carModel.copyWith(
        adi: controllerAdi.text.trim().toUpperCase(),
        yakitTuru: (controllerYakitTuru.text.trim()).YakitTuruValu,
        aracDepo: double.tryParse(controllerAracDepo.text.trim().toUpperCase()),
        aracLpgDepo:
            double.tryParse(controllerLpgDepo.text.trim().toUpperCase()),
        imagePath: image == null ? null : image!.path);
  }
}

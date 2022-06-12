import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yakit_takip_2022/enum/yakit_turu_enum.dart';

import 'package:yakit_takip_2022/services/database_service.dart';

import '../../model/car_model.dart';

class AddNewCarViewModel extends ChangeNotifier {
  late CarModel carModel;
  late bool isNew;
  late int _color;
  final formKey = GlobalKey<FormState>();

  set color(int color) {
    _color = color;
    notifyListeners();
  }

  int get color => _color;

  late TextEditingController controllerAdi, controllerYakitTuru, controllerLpgDepo, controllerAracDepo, controllerAracKm;

  final DatabaseService _dbServis = DatabaseService.instance!;

  File? image;

  final picker = ImagePicker();

  getImage(bool issourceGallery) async {
    final pickedFile = await picker.pickImage(source: issourceGallery ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      image = await _cropImage(image);
    }

    notifyListeners();
  }

  Future<File?>? _cropImage(File? image) async {
    var croppedFile = await ImageCropper.platform.cropImage(sourcePath: image!.path, aspectRatioPresets: [
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
    color = Color(0xFFFF1451).value;
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
    controllerAracKm = TextEditingController();
  }
  AddNewCarViewModel.show({required this.carModel}) {
    isNew = false;
    color = carModel.color ?? const Color(0xFFFF1451).value;
    controllerAdi = TextEditingController(text: carModel.adi)
      ..addListener(() {
        notifyListeners();
      });
    controllerYakitTuru = TextEditingController(text: carModel.yakitTuru!.name)
      ..addListener(() {
        notifyListeners();
      });
    controllerLpgDepo = TextEditingController(text: carModel.aracLpgDepo.toString());
    controllerAracDepo = TextEditingController(text: carModel.aracDepo.toString());
    controllerAracKm = TextEditingController(text: carModel.aracKm.toString());
    image = carModel.imagePath == null ? null : File(carModel.imagePath!);
  }

  CarModel modeliHazirla() {
    return carModel = carModel.copyWith(
        aracKm: double.tryParse(controllerAracKm.text.trim().toUpperCase()),
        adi: controllerAdi.text.trim().toUpperCase(),
        yakitTuru: (controllerYakitTuru.text.trim()).YakitTuruValu,
        aracDepo: double.tryParse(controllerAracDepo.text.trim().toUpperCase()),
        aracLpgDepo: double.tryParse(controllerLpgDepo.text.trim().toUpperCase()),
        imagePath: image == null ? null : image!.path,
        color: color);
  }

  renkSec(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: Colors.deepOrange,
                onColorChanged: (secilenRenk) {
                  color = secilenRenk.value;

                  image = null;
                  carModel.imagePath = null;

                  Navigator.pop(context);
                },
              ),
            ),
          );
        });
  }
}

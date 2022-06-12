import 'package:flutter/material.dart';

import '../enum/yakit_turu_enum.dart';

class YakitTuruSecimDialog extends StatelessWidget {
  const YakitTuruSecimDialog({Key? key, this.isLpg = false}) : super(key: key);

  final bool isLpg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: ButtonBar(
        buttonAlignedDropdown: true,
        mainAxisSize: MainAxisSize.min,
        alignment: MainAxisAlignment.center,
        overflowDirection: VerticalDirection.down,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.LPG);
              },
              child:  Text(YakitTuruEnum.LPG.name.toUpperCase())),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.BENZIN);
              },
              child:  Text(YakitTuruEnum.BENZIN.name.toUpperCase())),
          Visibility(
            visible: !isLpg,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.DIZEL);
                },
                child:  Text(YakitTuruEnum.DIZEL.name.toUpperCase())),
          )
        ],
      ),
      title: const Text("YAKIT TÜRÜ SEÇİNİZ", textAlign: TextAlign.center),
    );
  }
}

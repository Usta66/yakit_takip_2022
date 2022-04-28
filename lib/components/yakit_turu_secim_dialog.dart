import 'package:flutter/material.dart';

import '../enum/yakit_turu_enum.dart';

class YakitTuruSecimDialog extends StatelessWidget {
  const YakitTuruSecimDialog({Key? key, this.isLpg = false}) : super(key: key);

  final bool isLpg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.LPG);
                },
                child: const Text("LPG")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.BENZIN);
                },
                child: const Text("BENZİN")),
            Visibility(
              visible: !isLpg,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.DIZEL);
                  },
                  child: const Text("DİZEL")),
            )
          ],
        ),
      ),
      title: const Text("YAKIT TÜRÜ SEÇİNİZ"),
    );
  }
}

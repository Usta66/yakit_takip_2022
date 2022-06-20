import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../enum/yakit_turu_enum.dart';
import '../utils/locale_keys.g.dart';

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
              child: Text(YakitTuruEnum.LPG.name.tr().toUpperCase())),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.BENZIN);
              },
              child: Text(YakitTuruEnum.BENZIN.name.tr().toUpperCase())),
          Visibility(
            visible: !isLpg,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop<YakitTuruEnum>(YakitTuruEnum.DIZEL);
                },
                child: Text(YakitTuruEnum.DIZEL.name.tr().toUpperCase())),
          )
        ],
      ),
      title: Text(LocaleKeys.yakitTuruSeciniz.tr(),
          textAlign: TextAlign.center),
    );
  }
}

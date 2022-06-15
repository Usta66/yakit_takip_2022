import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../services/admob_service.dart';

class MyBannerAdWidget extends StatelessWidget {
  const MyBannerAdWidget({Key? key, required this.size}) : super(key: key);
  final AdSize size;
  @override
  Widget build(BuildContext context) {
    return Consumer<AdmobService>(
      builder: (context, admobService, child) {
        AdmobService.instance!.bannerAdStart(size: size);

        if (admobService.isBannerReady) {
          return Padding(
            padding: EdgeInsets.only(top: context.normalValue),
            child: SizedBox(
              child: AdWidget(
                ad: admobService.bannerAd,
              ),
              height: admobService.bannerAd.size.height.toDouble(),
            ),
          );
        } else {
          return SizedBox(height: admobService.bannerAd.size.height.toDouble());
        }
      },
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/deneme/admob_stateless_view_model.dart';
import 'package:yakit_takip_2022/services/admob_service.dart';

class AdmobView extends StatelessWidget {
  const AdmobView({Key? key, required this.viewModel}) : super(key: key);

  final AdmobStatelessViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(height: 70, color: Colors.amber),
                Container(height: 70, color: Colors.amber),
                Consumer<AdmobService>(
                  builder: (context, value, child) {
                    if (value.getIsbannerReady) {
                      return Container(
                        height: value.getBannderAd().size.height.toDouble(),
                        width: value.getBannderAd().size.width.toDouble(),
                        child: AdWidget(ad: value.getBannderAd()),
                      );
                    }

                    return SizedBox();
                  },
                ),
                Container(height: 70, color: Colors.amber),
                Container(height: 70, color: Colors.amber),
                Consumer<AdmobService>(
                  builder: (context, value, child) {
                    return ElevatedButton(
                        onPressed: () {
                          if (value.getIsInterstitialAdReady) {
                            value.getInterstitialAd.show();
                          }
                        },
                        child: Text("Reklam Göster"));
                  },
                )
              ],
            ),
          ),
        ));
  }
}
 */
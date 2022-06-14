import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobDenemeView extends StatefulWidget {
  AdmobDenemeView({Key? key}) : super(key: key);

  @override
  State<AdmobDenemeView> createState() => _AdmobDenemeViewState();
}

class _AdmobDenemeViewState extends State<AdmobDenemeView> {
  late BannerAd _bannerAd;
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;
  bool _isBannerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            _isBannerReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print(error.message);
          _isBannerReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();

    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          this._interstitialAd = ad;
          _isInterstitialAdReady = true;
        }, onAdFailedToLoad: (eror) {
          print(eror.message);
        }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(height: 70, color: Colors.amber),
            Container(height: 70, color: Colors.amber),
            if (_isBannerReady)
              Container(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(ad: _bannerAd,key: Key("value"),),
              ),
            Container(height: 70, color: Colors.amber),
            
            Container(height: 70, color: Colors.amber),
           
            ElevatedButton(
                onPressed: () {
                  if (_isInterstitialAdReady) {
                    _interstitialAd.show();
                  }
                },
                child: Text("Reklam Göster"))
          ],
        ),
      ),
    );
  }
}

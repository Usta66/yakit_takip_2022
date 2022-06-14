import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService extends ChangeNotifier {
  static AdmobService? _instance;

  static AdmobService? get instance {
    _instance ??= AdmobService._init();

    return _instance;
  }

  bool isBannerReady = false;

  late BannerAd bannerAd;

  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

  AdmobService._init() {
    /*   bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(onAdLoaded: (ad) {
          isBannerReady = true;
          notifyListeners();
          print("admob calıştı");
        }, onAdFailedToLoad: (ad, error) {
          print(" admob hata${error.message}");

          isBannerReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load(); */

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

  // BannerAd get getBannerAd => _bannerAd;
  void setIsBannerReady(bool value) {
    isBannerReady = value;
    print("------------------------------------------------------------------------------------------setIsBannerReady");

     notifyListeners();
  }

  void bannerAdStart({required AdSize size}) {
    bannerAd = BannerAd(
        size: size,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(onAdLoaded: (ad) {
          if (isBannerReady == false) {
            setIsBannerReady(true);
          }

          //notifyListeners();
          print("admob calıştı");
        }, onAdFailedToLoad: (ad, error) {
          print(" admob hata${error.message}");

          // isBannerReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

   InterstitialAd get getInterstitialAd => _interstitialAd;
  bool get getIsInterstitialAdReady => _isInterstitialAdReady;

/*   @override
  void dispose() {
    print("dispos çalıştı" * 10);
    // TODO: implement dispose
    super.dispose();

    _bannerAd.dispose();
  } */
}

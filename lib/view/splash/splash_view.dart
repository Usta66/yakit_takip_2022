import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/constants/app_constants.dart';
import 'package:yakit_takip_2022/view/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key, required this.viewModel}) : super(key: key);
  final SplashViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(viewModel: viewModel, child: Scaffold(
      body: SafeArea(child: Lottie.asset(LottieConstants.instance!.BENZIN_DOLUM)),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:yakit_takip_2022/base/base_view.dart';
import 'package:yakit_takip_2022/navigation/navigation_route_services.dart';
import 'package:yakit_takip_2022/navigation/navigation_services.dart';
import 'package:yakit_takip_2022/view/onboard/onboard_view_model.dart';

import 'onboard_model.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key, required this.viewModel}) : super(key: key);
  final OnboardViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        viewModel: viewModel,
        child: Scaffold(
          body: Padding(
            padding: context.horizontalPaddingNormal,
            child: Column(
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 5,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        viewModel.changeCurrentIndex(value);
                      },
                      itemCount: viewModel.onboardItems.length,
                      itemBuilder: (context, index) => builColumnBody(context, viewModel.onboardItems[index]),
                    )),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: context.paddingLow,
                                  child: Consumer<OnboardViewModel>(
                                    builder: (context, value, child) => CircleAvatar(
                                      backgroundColor: const Color.fromARGB(255, 69, 18, 196).withOpacity(viewModel.curruntIndex == index ? 1 : 0.2),
                                      radius: viewModel.curruntIndex == index ? context.width * 0.015 : context.width * 0.01,
                                    ),
                                  ),
                                );
                              },
                            )),
                        const Spacer(),
                        FloatingActionButton(
                            backgroundColor: const Color.fromARGB(255, 69, 18, 196),
                            child: const Icon(Icons.keyboard_arrow_right_sharp),
                            onPressed: () {
                              goToViewReset(path: NavigationEnum.aracIslem);
                            })
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Column builColumnBody(BuildContext context, OnboardModel onboardItem) {
    return Column(
      children: [Expanded(flex: 5, child: buildSvgPicture(onboardItem.imagePath)), buildColumnDescription(context, onboardItem)],
    );
  }

  Column buildColumnDescription(BuildContext context, OnboardModel onboardItem) {
    return Column(
      children: [
        Text(onboardItem.title,
            textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
        Padding(
          padding: context.horizontalPaddingMedium,
          child: Text(
            onboardItem.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold, color: Colors.black45),
          ),
        )
      ],
    );
  }

  SvgPicture buildSvgPicture(String imagePath) {
    return SvgPicture.asset(imagePath);
  }
}

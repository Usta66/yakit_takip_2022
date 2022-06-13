import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yakit_takip_2022/constants/app_constants.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'navigation/navigation_route_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(EasyLocalization(
      startLocale: const Locale("tr", "TR"),
      supportedLocales: const [
        LocaleConstants.EN_LOCALE,
        LocaleConstants.TR_LOCALE
      ],
      path: LocaleConstants.LANG_PATH,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'Yakıt Takip',
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.amber,
          textTheme:
              const TextTheme(subtitle2: TextStyle(color: Colors.amber))),
      initialRoute: "aracListesi",
      navigatorKey: NavigationServices.instance.navigatorKey,

      onGenerateRoute: (settings) =>
          NavigatorRouteServices.onRouteGenarete(settings),

      //home: MyHomePage(),
    );
  }
}

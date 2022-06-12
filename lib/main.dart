import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:yakit_takip_2022/navigation/navigation_services.dart';

import 'navigation/navigation_route_services.dart';

void main() async {
  //WidgetsFlutterBinding();
  //DatabaseService.instance;

  runApp(EasyLocalization(
      startLocale: const Locale("tr", "TR"),
      supportedLocales: [const Locale("tr", "TR")],
      path: "assets/lang",
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      title: 'Flutter Demo',
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

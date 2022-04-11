import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';

import 'package:yakit_takip_2022/view/arac_list/arac_list_view.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

void main() async {
  //WidgetsFlutterBinding();
  //DatabaseService.instance;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AracListViewModel>(
      create: (context) => AracListViewModel(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => AracListView(viewModel: AracListViewModel()),
        'add': (context) =>
            AddNewCarView(viewModel: AddNewCarViewModel.addNew())
      },
    );
  }
}

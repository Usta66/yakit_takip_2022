import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';
import 'package:yakit_takip_2022/model/yakit_islem_model.dart';
import 'package:yakit_takip_2022/services/database_service.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import 'view/home/home_view.dart';

void main() async {
  // WidgetsFlutterBinding();
  // DatabaseService? db = DatabaseService.instance;

  runApp(const MyApp());
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
      home:
          //AddNewCarView(viewModel: AddNewCarViewModel.addNew())
          AracListView(viewModel: AracListViewModel()),
    );
  }
}

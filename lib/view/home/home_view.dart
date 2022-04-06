import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/model/car_model.dart';

import '../../services/database_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
    );
  }
}

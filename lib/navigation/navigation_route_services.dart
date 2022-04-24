import 'package:flutter/material.dart';
import 'package:yakit_takip_2022/navigation/navigation_enum.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view.dart';
import 'package:yakit_takip_2022/view/add_new_car/add_new_car_view_model.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view.dart';
import 'package:yakit_takip_2022/view/arac_list/arac_list_view_model.dart';

import '../model/car_model.dart';

class NavigatorRouteServices {
  NavigatorRouteServices._init();

  static Route<dynamic> onRouteGenarete(RouteSettings settings) {
    switch (settings.name) {
      case "aracListesi":
        return _navigateToDeafult(
            page: AracListView(viewModel: AracListViewModel()));

      case "aracEkleme":
        return _navigateToDeafult<CarModel>(
            page: AddNewCarView(viewModel: AddNewCarViewModel.addNew()));

      case "aracGuncelleme":

       AddNewCarViewModel? _viewModel;
        if (settings.arguments == null) {
          _viewModel = AddNewCarViewModel.addNew();
        } else {
          _viewModel = settings.arguments as AddNewCarViewModel;
        }
         return _navigateToDeafult<CarDeletModel>(
          
            page: AddNewCarView(viewModel:_viewModel )); 
      default:
        throw ("navigatorde sıkıntı var");
    }
  }

  static MaterialPageRoute<R> _navigateToDeafult<R>({required Widget page}) {
    return MaterialPageRoute<R>(
      builder: (context) => page,
    );
  }
}

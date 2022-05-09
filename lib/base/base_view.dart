import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatelessWidget {
  const BaseView({Key? key, required this.viewModel, required this.child}) : super(key: key);

  final T viewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: child,
      ),
    );
  }
}

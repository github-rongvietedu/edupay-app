import 'package:flutter/material.dart';
import 'base_controller.dart';
export 'base_controller.dart';

abstract class BaseViewModel<T extends BaseController> extends StatelessWidget {
  BaseViewModel({Key? key}) : super(key: key);

  final String tag = '';

  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return Obx(() => baseBuilder(context));
  }

  Widget baseBuilder(context);
}

abstract class BaseView<T extends BaseController> extends StatelessWidget {
  BaseView({Key? key}) : super(key: key);

  String get tag => '';
  T get controller => GetInstance().find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (controller) {
        return baseBuilder(context);
      },
    );
  }

  Widget baseBuilder(BuildContext context);
}

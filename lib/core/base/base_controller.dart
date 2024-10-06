import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_common_widgets.dart';
import 'widget_state.dart' as widgetState;

export 'package:get/get.dart';

class BaseController extends GetxController
    with BaseCommonWidgets, widgetState.WidgetState, widgetState.ScreenState {
  bool isLoadMore = false;
  bool withScrollController = false;
  ScrollController? scrollController;

  set setEnableScrollController(bool value) => withScrollController = value;

  @override
  void onInit() {
    super.onInit();
    if (withScrollController) {
      scrollController = ScrollController();
      scrollController?.addListener(_scrollListener);
    }
  }

  void onRefresh() {}

  void onLoadMore() {}

  void _scrollListener() {
    if (scrollController != null) {
      if ((scrollController?.offset ?? 0) >=
              (scrollController?.position.maxScrollExtent ?? 0) &&
          scrollController?.position.outOfRange == false) {
        if (!isLoadMore) {
          isLoadMore = true;
          update();
          onLoadMore();
        }
      }
    }
    _innerBoxScrolled();
  }

  void _innerBoxScrolled() {
    if ((scrollController?.offset ?? 0) <= 60 &&
        (scrollController?.offset ?? 0) > 40) {
      // if(!innerBoxIsScrolled) {
      //   innerBoxIsScrolled = true;
      //   update();
      // }
    }
    if ((scrollController?.offset ?? 0) >= 0 &&
        (scrollController?.offset ?? 0) <= 40) {
      // if(innerBoxIsScrolled) {
      //   innerBoxIsScrolled = false;
      //   update();
      // }
    }
  }
}

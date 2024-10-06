import 'package:get/get.dart';

import 'base_controller.dart';
import 'base_view_view_model.dart';

enum State { OK, ERROR, LOADING }

mixin WidgetState {
  final Rx<State> _widgetState = State.LOADING.obs;
  Rx<State> stateLoading = State.LOADING.obs;
  Rx<State> stateOk = State.OK.obs;
  Rx<State> stateError = State.ERROR.obs;

  Rx<State> get getWiState => _widgetState;

  set setWiState(Rx<State> event) => _widgetState.value = event.value;

  bool get wiStateIsLoading => _widgetState.value == stateLoading.value;

  bool get wiStateIsOK => _widgetState.value == stateOk.value;

  bool get wiStateIsError => _widgetState.value == stateError.value;
}

mixin ScreenState {
  State _screenState = State.LOADING;
  State screenStateLoading = State.LOADING;
  State screenStateOk = State.OK;
  State screenStateError = State.ERROR;

  State get getScreenState => _screenState;

  set setScreenState(State event) => _screenState = event;

  bool get screenStateIsLoading => _screenState == screenStateLoading;

  bool get screenStateIsOK => _screenState == screenStateOk;

  bool get screenStateIsError => _screenState == screenStateError;
}

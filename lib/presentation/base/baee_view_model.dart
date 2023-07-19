import 'dart:async';

import 'package:advanced_course/presentation/common/state_renderer/state_renderer_implementer.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
final   StreamController _inpurStreamController=StreamController<FlowState>.broadcast(); 


@override
  // TODO: implement inputState
  Sink get inputState =>_inpurStreamController.sink ;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState => _inpurStreamController.stream.map((flowState) => flowState );
@override
void dispose() {
  _inpurStreamController.close();  
} 



}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState >get outputState;
}

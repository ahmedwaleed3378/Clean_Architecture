import 'dart:async';

import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/domain/usecase/reset_password_usecase.dart';
import 'package:advanced_course/presentation/base/baee_view_model.dart';
import 'package:advanced_course/presentation/common/freezed_data_class.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_implementer.dart';
import '../../resources/strings_manager.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  //forget password data object
  var resetPasswordObject = ResetPasswordObject('');
  // forget password usecase instance
  final ResetPasswordUseCase _resetPasswordUseCase;
  ForgotPasswordViewModel(this._resetPasswordUseCase);
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _resetEnabledStreamController =
      StreamController<void>.broadcast();
  @override
  void start() {
    //show content state
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _resetEnabledStreamController.close();
    super.dispose();
  }

  //inputs
  @override
  Sink get resetEnbledSink => _resetEnabledStreamController.sink;
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  void resetPassword() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: Strings.loading));
    (await _resetPasswordUseCase
            .execute(ResetPasswordRequest(email: resetPasswordObject.email)))
        .fold((failure) {
      inputState.add(
        ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message),
      );
    }, (data) {
       inputState.add(ContentState());
    });
  }

  @override
  setEmail(String email) {
    _emailStreamController.add(email);
    resetPasswordObject = resetPasswordObject.copyWith(email: email);
    resetEnbledSink.add(null);
    // validReset.add(null);
  }

  //outputs
  @override
  Stream<bool> get isEmailValid =>
      _emailStreamController.stream.map((email) => isEmailEmpty(email));

  bool isEmailEmpty(String email) {
    return email.isNotEmpty;
  }

  @override
  Stream<bool> get isResetEnabled => _resetEnabledStreamController.stream
      .map((event) => isEmailEmpty(resetPasswordObject.email));
}

abstract class ForgotPasswordViewModelInputs {
  setEmail(String email);
  void resetPassword();
  Sink get inputEmail;
  Sink get resetEnbledSink;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get isEmailValid;
  Stream<bool> get isResetEnabled;
}

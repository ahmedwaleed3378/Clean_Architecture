import 'dart:async';

import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/domain/usecase/login_usaecase.dart';
import 'package:advanced_course/presentation/base/baee_view_model.dart';
import 'package:advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_course/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';

import '../../common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  LoginViewModel(this._loginUseCase);

  final LoginUseCase _loginUseCase;

  var loginObject = LoginObject('', '');
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passStreamController =
      StreamController<String>.broadcast();
  final StreamController _loginEnabledStreamController =
      StreamController<void>.broadcast();
        StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();


  @override
  void dispose() {
    _userNameStreamController.close();
    _passStreamController.close();
    _loginEnabledStreamController.close();
     isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view model should tell view to show content state
    inputState.add(ContentState());
  }

//inputs

  @override
  Sink get inputPassword => _passStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get validLogin => _loginEnabledStreamController.sink;

  @override
  void login() async {
    inputState.add(
      LoadingState(
          stateRendererType: StateRendererType.POPUP_LOADING_STATE,
          message: Strings.loading),
    );
    (await _loginUseCase.execute(
      LoginRequest(email: loginObject.userName, password: loginObject.password),
    ))
        .fold((failure) {
      //failure
      inputState.add(
      ErrorState( StateRendererType.POPUP_ERROR_STATE,
      failure.message),
    );
    }, (data) {


      inputState.add(ContentState());

       isUserLoggedInSuccessfullyStreamController.add(true);
    
    });
  }

  @override
  setPassword(String pass) {
    _passStreamController.add(pass);
    loginObject = loginObject.copyWith(password: pass);
    validLogin.add(null);
  }

  @override
  setUserName(String userName) {
    _userNameStreamController.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    validLogin.add(null);
  }

//outputs

  @override
  Stream<bool> get isPasswordVaild =>
      _passStreamController.stream.map((password) => isPassValid(password));
  @override
  Stream<bool> get isUserNameVaild => _userNameStreamController.stream
      .map((username) => isUserNameValid(username));

  @override
  Stream<bool> get isLoginEnabled =>
      _loginEnabledStreamController.stream.map((_) => _areAllInputsValid());

  bool isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool isPassValid(String password) {
    return password.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return isUserNameValid(loginObject.userName) &&
        isPassValid(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);
  setPassword(String pass);
  void login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get validLogin;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get isPasswordVaild;
  Stream<bool> get isUserNameVaild;
  Stream<bool> get isLoginEnabled;
}

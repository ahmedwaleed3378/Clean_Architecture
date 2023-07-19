import 'package:advanced_course/app/di.dart';
import 'package:advanced_course/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:advanced_course/presentation/login/view_model/login_viewmodel.dart';
import 'package:advanced_course/presentation/resources/color_manager.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';
import 'package:advanced_course/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../app/app_preferences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passController
        .addListener(() => _viewModel.setPassword(_passController.text));
          _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _userNameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContent(), () {
                _viewModel.login();
              }) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.isUserNameVaild,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                          hintText: Strings.usename,
                          labelText: Strings.usename,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : Strings.usenameError),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.isPasswordVaild,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passController,
                      decoration: InputDecoration(
                          hintText: Strings.password,
                          labelText: Strings.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : Strings.passwordError),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.isLoginEnabled,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () async {
                                  _viewModel.login();
                                }
                              : null,
                          child: const Text(Strings.login)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p28, vertical: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.forgotPasswordRoute);
                      },
                      child: Text(
                        Strings.forgetPass,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(
                        Strings.registerText,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

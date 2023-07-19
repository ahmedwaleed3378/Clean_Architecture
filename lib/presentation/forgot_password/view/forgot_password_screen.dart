
import 'package:advanced_course/presentation/common/state_renderer/state_renderer_implementer.dart';
import 'package:advanced_course/presentation/forgot_password/view_model/forgot_password_viewmodel.dart';
import 'package:advanced_course/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();
  final TextEditingController _emaiController = TextEditingController();
  _bind() {
    _viewModel.start();
    _emaiController.addListener(() {
      _viewModel.setEmail(_emaiController.text);
    });
  }

  @override
  void dispose() {
    _emaiController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (BuildContext context, snapshot) {
          return snapshot.data?.getScreenWidget
          
          (context, _getContent(), () {}) ??
              _getContent();
        },
      ),
    );
  }

  SingleChildScrollView _getContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(ImageAssets.splashLogo),
            ),
            const SizedBox(
              height: AppSize.s44,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _viewModel.isEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emaiController,
                      decoration: InputDecoration(
                        hintText: Strings.email,
                        labelText: Strings.email,
                        errorText:
                            (snapshot.data ?? true) ? null : Strings.emailError,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: AppSize.s53,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p45),
              child: SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: StreamBuilder<bool>(
                    stream: _viewModel.isResetEnabled,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _viewModel.resetPassword();
                              }
                            : null,
                        child: const Text(Strings.resetPassword),
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: AppSize.s25,
            ),
            TextButton(
              onPressed: () async {},
              child: Text(
                Strings.resendEmail,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

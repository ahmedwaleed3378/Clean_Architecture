// ignore_for_file: constant_identifier_names

import 'package:advanced_course/presentation/resources/assets_manager.dart';
import 'package:advanced_course/presentation/resources/color_manager.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';
import 'package:advanced_course/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/font_manager.dart';

enum StateRendererType {
  // POPUP
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //FULL SCREEN
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_EMPTY_STATE,

  //GEENERAL
  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  const StateRenderer(
      {super.key,
      required this.stateRendererType,
      required this.message,
      required this.title,
      required this.retryActionFunction});
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function retryActionFunction;
  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.loadingJson),
          ],
        );
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(Strings.ok, context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonAssets.loadingJson),
            _getMessage(message),
          ],
        );
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(Strings.retryAgain, context)
        ]);
      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _getItemsColumn(
          [
            _getAnimatedImage(JsonAssets.emptyJson),
            _getMessage(message),
          ],
        );
      case StateRendererType.CONTENT_STATE:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getItemsColumn(List<Widget> widgets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14)),
        elevation: AppSize.s1,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: const [BoxShadow(color: Colors.black26)]),
          child: _getDialogContent(context, children),
        ),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  //retry function state
                  retryActionFunction.call();
                } else {
                  //popup state
                  Navigator.of(context).pop();
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getMessage(String message) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(AppPadding.p18),
      child: Text(
        message,
        style:
            TextStyle(color: ColorManager.black, fontSize: FontSizeManager.s18),
      ),
    ));
  }
}

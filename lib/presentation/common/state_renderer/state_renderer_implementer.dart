import 'package:advanced_course/app/constants.dart';
import 'package:advanced_course/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message = Strings.loading;
  LoadingState({
    required this.stateRendererType,
    this.message = Strings.loading,
  });
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP,FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => AppConstants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;
}

// EMPTY STATE

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULL_SCREEN_EMPTY_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            // show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
                title: '',
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {         
             _dismesDialog(context);

          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            // show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          } else {
            // full screen loading state
            return StateRenderer(
                title: '',
                message: getMessage(),
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction);
          }
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              title: '',
              retryActionFunction: retryActionFunction);
        }
      case ContentState:
        { 
          _dismesDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          _dismesDialog(context);
          return contentScreenWidget;
        }
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  _dismesDialog(BuildContext context){
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            title: '',
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }
}

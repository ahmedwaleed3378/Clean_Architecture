import 'dart:async';

import 'package:advanced_course/domain/models/models.dart';

import '../../base/baee_view_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controllers outputs
 final  StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;

  int _currentPage = 0;

  //OnBoarding ViewModel Inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = slidingObjects();
    postDataToView();
  }

  @override
  @override
  void onPageChanged(int index) {
    _currentPage = index;
    postDataToView();
  }

  @override
  int goPrevious() {
      int prevIndex =--_currentPage;
    if (prevIndex == -1) {
      prevIndex +=_list.length;
    }
    return prevIndex;
  }
  @override
  int goNext() {
    int nextIndex =++_currentPage;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject {
    return _streamController.stream.map((event) => event);
  }

  List<SliderObject> slidingObjects() {
    return [
      SliderObject(
          title: Strings.onBoardingTitle1,
          subTitle: Strings.onBoardingsubTitle1,
          image: ImageAssets.onboardinglogo1),
      SliderObject(
          title: Strings.onBoardingTitle2,
          subTitle: Strings.onBoardingsubTitle2,
          image: ImageAssets.onboardinglogo2),
      SliderObject(
          title: Strings.onBoardingTitle3,
          subTitle: Strings.onBoardingsubTitle3,
          image: ImageAssets.onboardinglogo3),
      SliderObject(
          title: Strings.onBoardingTitle4,
          subTitle: Strings.onBoardingsubTitle4,
          image: ImageAssets.onboardinglogo4),
    ];
  }

  void postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        numOfSlides:_list.length,
        currentSlideIndex: _currentPage ,
        sliderObject: _list[_currentPage]));
  }

}

// inputs mean that "Orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on left arrow or swipe right
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

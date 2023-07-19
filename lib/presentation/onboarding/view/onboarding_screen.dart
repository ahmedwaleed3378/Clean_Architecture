import 'package:advanced_course/app/app_preferences.dart';
import 'package:advanced_course/app/di.dart';
import 'package:advanced_course/presentation/onboarding/view_model/onboardingviewmodel.dart';
import 'package:advanced_course/presentation/resources/assets_manager.dart';
import 'package:advanced_course/presentation/resources/color_manager.dart';
import 'package:advanced_course/presentation/resources/constants_manager.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';
import 'package:advanced_course/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/models/models.dart';
import '../../resources/routes_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  final OnBoardingViewModel onBoardingViewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences=instance<AppPreferences>();



  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    onBoardingViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  Widget _getContent(SliderViewObject? sliderViewObject) {
    if (sliderViewObject ==null) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return OnBoardingPage(sliderViewObject!.sliderObject);
        },
        onPageChanged: (value) {
          onBoardingViewModel.onPageChanged(value);
        },
        controller: _pageController,
        itemCount: sliderViewObject!.numOfSlides,
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.loginRoute);
                    },
                    child: Text(
                      Strings.skip,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: onBoardingViewModel.outputSliderViewObject,
      builder: (BuildContext context, AsyncSnapshot<SliderViewObject> snapshot) {
        return _getContent(snapshot.data);
      },
    );
  }

  @override
  void dispose() {
    onBoardingViewModel.dispose();
    super.dispose();
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftarrowic),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(onBoardingViewModel.goPrevious(),
                    duration: const Duration(milliseconds: Constants.boarding),
                    curve: Curves.bounceInOut);
              },
            ),
          )

// circle indicator

          // right arrow
          ,
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child:
                      _getProperCircle(i, sliderViewObject.currentSlideIndex),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
                child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightarrowic),
                ),
                onTap: () {
                  // go to previous slide
                  _pageController.animateToPage(onBoardingViewModel.goNext(),
                      duration:
                          const Duration(milliseconds: Constants.boarding),
                      curve: Curves.bounceInOut);
                }),
          )
        ],
      ),
    );
  }

  _getProperCircle(int i, int currentIndex) {
    if (i == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowcircleic);
    } else {
      return SvgPicture.asset(ImageAssets.solidcircleic);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(this._sliderObject);
  final SliderObject _sliderObject;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}

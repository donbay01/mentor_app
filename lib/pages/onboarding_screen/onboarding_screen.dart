import 'dart:async';

import 'package:career_paddy/components/onboarding_carousel/Slider/slider_one.dart';
import 'package:career_paddy/components/onboarding_carousel/Slider/slider_three.dart';
import 'package:career_paddy/components/onboarding_carousel/carousel.dart';
import 'package:career_paddy/pages/Authentication/get_started.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/onboarding_carousel/Slider/slider_two.dart';
import '../../theme/text_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  int currentIndex = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }



  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
                _pageController.animateToPage(
                  currentIndex = 2,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                );
              },
              child: currentIndex == 2 ? Text('') : Text(
                'Skip',
                style: mediumBold(primaryWhite),
              )
          )
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                colors: [primaryBlue, secondaryBlue],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  _carousel(),
                  const SizedBox(
                    height: 15,
                  ),
                  currentIndex == 2
                      ? Container(
                          height: size.height * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => GetStarted()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryWhite,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: mediumBold(primaryBlue),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentIndex++;
                                  });
                                  _pageController.animateToPage(
                                    currentIndex,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: Text(
                                  'Next',
                                  style: mediumBold(primaryWhite),
                                )),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      duration: const Duration(milliseconds: 250),
      height: 4.0,
      width: isActive ? 5.0 : 5.0,
      decoration: BoxDecoration(
        color: isActive ? primaryWhite : darkBlue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _carousel() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [Slider1(), Slider2(), Slider3()],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

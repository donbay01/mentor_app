import 'dart:async';

import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'Slider/slider_one.dart';
import 'Slider/slider_two.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final int _numPages = 2;
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
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (currentIndex < 2 && _pageController.hasClients) {
        currentIndex++;
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = -1;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.45,
            width: size.width,
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                Slider1(),
                Slider2(),
              ],
            ),
          ),
          const SizedBox(height: 40,),
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

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      duration: const Duration(milliseconds: 250),
      height: 4.0,
      width: isActive ? 5.0 : 5.0,
      decoration: BoxDecoration(
        color: isActive ? primaryWhite :darkBlue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

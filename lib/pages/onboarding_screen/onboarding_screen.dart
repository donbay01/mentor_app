import 'package:career_paddy/components/onboarding_carousel/Slider/slider_one.dart';
import 'package:career_paddy/components/onboarding_carousel/Slider/slider_three.dart';
import 'package:career_paddy/pages/Authentication/get_started.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../components/onboarding_carousel/Slider/slider_two.dart';
import '../../theme/text_style.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

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
            onPressed: () async {
              if (currentIndex != 2) {
                var box = await Hive.openBox('app');
                await box.put('onboarding', true);
                await box.close();
              }

              setState(() {
                currentIndex = 2;
              });
            },
            child: currentIndex == 2
                ? Text('')
                : Text(
                    'Skip',
                    style: mediumBold(primaryWhite),
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
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
                  height: 40,
                ),
                SizedBox(
                  height: size.height / 2,
                  child: FlutterCarousel(
                    items: const [
                      Slider1(),
                      Slider2(),
                      Slider3(),
                    ],
                    options: CarouselOptions(
                      onPageChanged: (index, reason) => setState(() {
                        currentIndex = index;
                      }),
                      showIndicator: true,
                      floatingIndicator: true,
                      viewportFraction: 1,
                      slideIndicator: CircularSlideIndicator(
                        indicatorRadius: 4,
                        itemSpacing: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                currentIndex == 2
                    ? Container(
                        height: size.height * 0.06,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            var box = await Hive.openBox('app');
                            await box.put('onboarding', true);
                            await box.close();

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
                            },
                            child: Text(
                              'Next',
                              style: mediumBold(primaryWhite),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

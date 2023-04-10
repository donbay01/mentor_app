import 'dart:async';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../pages/profile/profile_screen.dart';
import '../../theme/color.dart';

class SmallBanners extends StatefulWidget {
  const SmallBanners({super.key});

  @override
  State<SmallBanners> createState() => _SmallBannersState();
}

class _SmallBannersState extends State<SmallBanners> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int currentIndex = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentIndex < 2 && pageController.hasClients) {
        currentIndex++;
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else {
        currentIndex = -1;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().getUser;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.1,
          width: size.width,
          child: PageView(
            onPageChanged: (i) {
              setState(() {
                currentIndex = i;
              });
            },
            controller: pageController,
            scrollDirection: Axis.horizontal,
            children: [
              if (!user.isCompleted) ...[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfilePage(),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/Banner.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              SvgPicture.asset(
                'assets/Career.svg',
                fit: BoxFit.cover,
                height: 100,
              ),
              SvgPicture.asset(
                'assets/Interview.svg',
                fit: BoxFit.cover,
                height: 100,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: SizedBox(
            height: 5,
            width: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if (!user.isCompleted) ...[
                  Container(
                    width: currentIndex == 0 ? 20 : 10,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: currentIndex == 0 ? primaryBlue : textGrey,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                ],
                Container(
                  width: currentIndex == 1 ? 20 : 10,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: currentIndex == 1 ? primaryBlue : textGrey,
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Container(
                  width: currentIndex == 2 ? 20 : 10,
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: currentIndex == 2 ? primaryBlue : textGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

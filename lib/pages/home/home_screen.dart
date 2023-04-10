import 'dart:async';
import 'package:career_paddy/components/drawer/drawer.dart';
import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/pages/notifications/notifications.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  var service = AuthService();
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 8), (Timer timer) {
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
  }

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;

    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(
          user: user,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi ${user.displayName!.split(' ').first}",
                      style: largeText(primaryBlack),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Notifications(),
                              ),
                            );
                          },
                          icon: Icon(Icons.notifications),
                        ),
                        GestureDetector(
                          onTap: () {
                            // scaffoldKey.currentState?.openDrawer();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyDrawer(user: user),
                              ),
                            );
                          },
                          child: ProfileIcon(
                            radius: 40,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    onPageChanged: (i) {
                      setState(() {
                        currentIndex = i;
                      });
                    },
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
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
                      InkWell(
                        onTap: () => {},
                        child: SvgPicture.asset(
                          'assets/Banner.svg',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
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
                    width: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

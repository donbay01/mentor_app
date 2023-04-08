import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/pages/learn/learn_screen.dart';
import 'package:career_paddy/pages/paddy/explore_screen.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../community/community_screen.dart';
import '../home/home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;

  @override
  void initState() {
    context.read<UserProvider>().listenToUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPages(),
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() {
    return BottomNavyBar(
      backgroundColor: primaryWhite,
      containerHeight: 60,
      itemCornerRadius: 10,
      selectedIndex: index,
      onItemSelected: (index) => setState(() {
        this.index = index;
      }),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: const Icon(
            FontAwesomeIcons.house,
            size: 20,
          ),
          title: Text(
            'Home',
            style: small(),
          ),
          textAlign: TextAlign.center,
          inactiveColor: Colors.grey,
          activeColor: secondaryBlue,
        ),
        BottomNavyBarItem(
          icon: const Icon(
            Icons.people_alt,
            size: 20,
          ),
          textAlign: TextAlign.center,
          title: Text(
            'Paddy',
            style: small(),
          ),
          inactiveColor: Colors.grey,
          activeColor: secondaryBlue,
        ),
        BottomNavyBarItem(
          icon: const Icon(
            FontAwesomeIcons.book,
            size: 20,
          ),
          textAlign: TextAlign.center,
          title: Text(
            'Learn',
            style: small(),
          ),
          inactiveColor: Colors.grey,
          activeColor: secondaryBlue,
        ),
        BottomNavyBarItem(
          icon: const Icon(
            FontAwesomeIcons.peopleGroup,
            size: 20,
          ),
          textAlign: TextAlign.center,
          title: Text(
            'Community',
            style: small(),
          ),
          inactiveColor: Colors.grey,
          activeColor: secondaryBlue,
        ),
      ],
    );
  }

  Widget buildPages() {
    switch (index) {
      case 1:
        return const ExploreScreen();
      // case 2:
      //   return Rankings();
      case 2:
        return const LearningScreen();
      case 3:
        return CommunityScreen();
      default:
        return const HomeScreen();
    }
  }
}

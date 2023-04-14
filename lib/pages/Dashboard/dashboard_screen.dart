import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/bottom_nav.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/learn/learn_screen.dart';
import 'package:career_paddy/pages/paddy/explore_screen.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../community/community_screen.dart';
import '../home/home_screen.dart';
import '../sessions/index.dart';

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
    context.read<InterestProvider>().load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<UserProvider>();
    var isLoaded = prov.getHasLoaded;
    var user = prov.getUser;

    return Scaffold(
      body: !isLoaded ? const Loader() : buildPages(user),
      bottomNavigationBar: buildBottomNavigation(user),
    );
  }

  Widget buildBottomNavigation(UserModel user) {
    return BottomNavyBar(
      backgroundColor: primaryWhite,
      containerHeight: 60,
      itemCornerRadius: 10,
      selectedIndex: index,
      onItemSelected: (index) => setState(() {
        this.index = index;
      }),
      items: user.role == MENTOR ? MENTOR_TABS : MENEE_TABS,
    );
  }

  Widget buildPages(UserModel user) {
    switch (index) {
      case 1:
        return user.role == MENTOR ? const MySessions() : const ExploreScreen();
      case 2:
        return const LearningScreen();
      case 3:
        return CommunityScreen();
      default:
        return const HomeScreen();
    }
  }
}

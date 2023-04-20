import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/Dashboard/bottom_nav.dart';
import 'package:career_paddy/pages/learn/learn_screen.dart';
import 'package:career_paddy/pages/paddy/explore_screen.dart';
import 'package:career_paddy/pages/profile/edit_paddyProfile.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/fcm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../community/community_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../sessions/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var service = AuthService();

  @override
  void initState() {
    context.read<InterestProvider>().load();
    FCMService.updateToken();
    super.initState();
  }

  check(UserModel user) {
    if (user.role == MENTOR && !user.reviewed) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => EditPaddyProfile(
            isNot: true,
          ),
        ),
        (route) => false,
      );
    }

    return;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = context.read<UserProvider>().user;
      if (user != null) {
        check(user);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<UserProvider>();
    var nav = context.watch<BottomNavProvider>();

    var user = prov.user;

    return user != null
        ? Scaffold(
            body: buildPages(
              user,
              nav.index,
            ),
            bottomNavigationBar: BottomNav(
              nav: nav,
              user: user,
            ),
          )
        : Loader();
  }

  Widget buildPages(UserModel user, int index) {
    switch (index) {
      case 1:
        return user.role == MENTOR ? const MySessions() : const ExploreScreen();
      case 2:
        return CourseList();
      case 3:
        return CommunityScreen();
      default:
        return const HomeScreen();
    }
  }
}

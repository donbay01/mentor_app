import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/dialogs/paddy_upgrade.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/Authentication/verify_email.dart';
import 'package:career_paddy/pages/Dashboard/bottom_nav.dart';
import 'package:career_paddy/pages/learn/coming_soon.dart';
import 'package:career_paddy/pages/learn/ongoing_course.dart';
import 'package:career_paddy/pages/paddy/explore_screen.dart';
import 'package:career_paddy/pages/profile/completed_mentor.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/providers/course.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/fcm.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:style_cron_job/style_cron_job.dart';
import '../community/community_screen.dart';
import '../home/home_screen.dart';
import '../sessions/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var service = AuthService();
  var period = every.x(2).week;

  @override
  void initState() {
    context.read<InterestProvider>().load();
    var prov = context.read<UserProvider>();
    prov.listenToUser();
    context.read<CourseProvider>().getMyCourses();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var user = prov.getUser;
      FCMService.updateToken(user.role);

      period.listen((time) {
        showDialog(
          context: context,
          builder: (ctx) => const PaddyUpgrade(),
        );
      });
    });
    super.initState();
  }

  check(UserModel user) async {
    var s = AuthService();
    var f = s.getFirebaseUser()!;
    if (!f.emailVerified) {
      await f.sendEmailVerification();
      SnackBarHelper.displayToastMessage(
        context,
        'You need to verify your email',
        primaryBlue,
      );
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmail(),
        ),
        (route) => false,
      );
    } else if (user.role == MENTOR && !user.reviewed) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => CompletedProfile(),
        ),
        (route) => false,
      );
    }

    return;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var prov = context.read<UserProvider>();
      var user = prov.user;
      if (user != null) {
        check(user);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    period.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<UserProvider>();
    var nav = context.watch<BottomNavProvider>();

    var user = prov.user;

    return user != null
        ? ShowCaseWidget(
            onFinish: () async {
              var box = await Hive.openBox('showcase');
              await box.put('shown', true);
              nav.setVisibility(false);
            },
            builder: Builder(
              builder: (ctx) => Scaffold(
                body: buildPages(
                  user,
                  nav.index,
                ),
                bottomNavigationBar: BottomNav(
                  nav: nav,
                  user: user,
                ),
              ),
            ),
          )
        : Scaffold(body: Loader());
  }

  Widget buildPages(UserModel user, int index) {
    switch (index) {
      case 1:
        return user.role == MENTOR ? const MySessions() : const ExploreScreen();
      case 2:
        return ComingSoon();
      case 3:
        return CommunityScreen();
      default:
        return const HomeScreen();
    }
  }
}

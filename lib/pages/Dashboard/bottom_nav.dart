import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/components/showcase/index.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../constants/bottom_nav.dart';
import '../../constants/role.dart';
import '../../providers/bottom_nav.dart';
import '../../theme/color.dart';

class BottomNav extends StatefulWidget {
  final BottomNavProvider nav;
  final UserModel user;

  const BottomNav({
    super.key,
    required this.nav,
    required this.user,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: primaryWhite,
      containerHeight: 60,
      itemCornerRadius: 10,
      selectedIndex: widget.nav.index,
      onItemSelected: (index) => widget.nav.setIndex(index),
      items: widget.user.role == MENTOR
          ? MENTOR_TABS
          : getMenteeTabs(_one, _two, _three, _four),
    );
  }
}

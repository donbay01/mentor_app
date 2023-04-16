import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../constants/bottom_nav.dart';
import '../../constants/role.dart';
import '../../providers/bottom_nav.dart';
import '../../theme/color.dart';

class BottomNav extends StatelessWidget {
  final BottomNavProvider nav;
  final UserModel user;

  const BottomNav({
    super.key,
    required this.nav,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      backgroundColor: primaryWhite,
      containerHeight: 60,
      itemCornerRadius: 10,
      selectedIndex: nav.index,
      onItemSelected: (index) => nav.setIndex(index),
      items: user.role == MENTOR ? MENTOR_TABS : MENEE_TABS,
    );
  }
}

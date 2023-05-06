import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
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

  Box? box;
  bool isShow = false;

  load() async {
    box = await Hive.openBox('showcase');
    isShow = box!.get('shown') != true;
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      load();
      ShowCaseWidget.of(context).startShowCase([
        _one,
        _two,
        _three,
        _four,
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<BottomNavProvider>();
    var isShowcase = prov.isShowcase;

    return BottomNavigationBar(
      backgroundColor: primaryWhite,
      showSelectedLabels: true,
      currentIndex: prov.index,
      selectedItemColor: primaryBlue,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: mediumText(primaryBlue),
      onTap: (i) => prov.setIndex(i),
      showUnselectedLabels: true,
      enableFeedback: true,
      items: widget.user.role == MENTOR
          ? MENTOR_TABS
          : getMenteeTabs(
              isShow,
              isShowcase,
              _one,
              _two,
              _three,
              _four,
            ),
    );
  }
}

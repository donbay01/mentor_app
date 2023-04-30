import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/components/showcase/index.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/color.dart';
import '../theme/text_style.dart';

List<BottomNavyBarItem> getMenteeTabs(one, two, three) {
  var MENEE_TABS = [
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
      icon: CustomShowcase(
        globalKey: one,
        description: buddy,
        child: const Icon(
          Icons.people_alt,
          size: 20,
        ),
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
      icon: CustomShowcase(
        description: learn,
        globalKey: two,
        child: const Icon(
          FontAwesomeIcons.book,
          size: 20,
        ),
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
      icon: CustomShowcase(
        description: community,
        globalKey: three,
        child: const Icon(
          FontAwesomeIcons.peopleGroup,
          size: 20,
        ),
      ),
      textAlign: TextAlign.center,
      title: Text(
        'Community',
        style: small(),
      ),
      inactiveColor: Colors.grey,
      activeColor: secondaryBlue,
    ),
  ];

  return MENEE_TABS;
}

var MENTOR_TABS = [
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
      'Sessions',
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
];

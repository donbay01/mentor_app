import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:career_paddy/components/showcase/index.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/color.dart';
import '../theme/text_style.dart';

List<BottomNavyBarItem> getMenteeTabs(one, two, three, four) {
  var MENEE_TABS = [
    BottomNavyBarItem(
      icon: CustomShowcase(
        title: 'Home',
        globalKey: one,
        description: home,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            FontAwesomeIcons.house,
            size: 20,
          ),
        ),
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
        title: 'Paddy',
        globalKey: two,
        description: buddy,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
              Icons.people_alt,
              color: primaryBlue,
              size: 20,
            ),
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
        title: 'Learn',
        description: learn,
        globalKey: three,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            FontAwesomeIcons.book,
            color: primaryBlue,
            size: 20,
          ),
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
        title: 'Community',
        description: community,
        globalKey: four,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            FontAwesomeIcons.peopleGroup,
            color: primaryBlue,
            size: 20,
          ),
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

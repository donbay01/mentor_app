import 'package:career_paddy/components/showcase/index.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/color.dart';

List<BottomNavigationBarItem> getMenteeTabs(
  isEnabled,
  active,
  one,
  two,
  three,
  four,
) {
  var MENEE_TABS = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: CustomShowcase(
        title: 'Home',
        globalKey: one,
        description: home,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            FontAwesomeIcons.house,
            color: active ? primaryBlue : null,
            size: 20,
          ),
        ),
      ),

      // inactiveColor: Colors.grey,
      // c: secondaryBlue,
    ),
    BottomNavigationBarItem(
      label: 'Paddy',
      icon: CustomShowcase(
        title: 'Paddy',
        globalKey: two,
        description: buddy,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.people_alt,
            color: active ? primaryBlue : null,
            size: 20,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Learn',
      icon: CustomShowcase(
        title: 'Learn',
        description: learn,
        globalKey: three,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            FontAwesomeIcons.book,
            color: active ? primaryBlue : null,
            size: 20,
          ),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Community',
      icon: CustomShowcase(
        title: 'Community',
        description: community,
        globalKey: four,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            FontAwesomeIcons.peopleGroup,
            color: active ? primaryBlue : null,
            size: 20,
          ),
        ),
      ),
    ),
  ];

  var REGULAR = [
    BottomNavigationBarItem(
      label: 'Home',
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          FontAwesomeIcons.house,
          // color: active ? primaryBlue : null,
          size: 20,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Paddy',
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          Icons.people_alt,
          // color: active ? primaryBlue : null,
          size: 20,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Learn',
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          FontAwesomeIcons.book,
          // color: active ? primaryBlue : null,
          size: 20,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: 'Community',
      icon: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(
          FontAwesomeIcons.peopleGroup,
          // color: active ? primaryBlue : null,
          size: 20,
        ),
      ),
    ),
  ];

  return isEnabled ? MENEE_TABS : REGULAR;
}

var MENTOR_TABS = [
  BottomNavigationBarItem(
    label: 'Home',
    icon: const Icon(
      FontAwesomeIcons.house,
      size: 20,
    ),
  ),
  BottomNavigationBarItem(
    label: 'Sessions',
    icon: const Icon(
      Icons.people_alt,
      size: 20,
    ),
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      FontAwesomeIcons.book,
      size: 20,
    ),
    label: 'Learn',
  ),
  BottomNavigationBarItem(
    icon: const Icon(
      FontAwesomeIcons.peopleGroup,
      size: 20,
    ),
    label: 'Community',
  ),
];

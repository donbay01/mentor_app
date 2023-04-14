import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/pages/home/mentee_points.dart';
import 'package:career_paddy/pages/home/mentor_points.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PointsUI extends StatelessWidget {
  const PointsUI({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return user.role == MENTOR
        ? MentorPoints(user: user)
        : MenteePoints(user: user);
  }
}

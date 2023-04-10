import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorsList extends StatelessWidget {
  const MentorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      shrinkWrap: true,
      itemBuilder: (context, documentSnapshots, index) {
        final doc = documentSnapshots[index];
        var user = UserModel.fromJson(doc.id, doc.data() as dynamic);

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              ProfileIcon(
                image: user.photoURL,
                radius: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    user.first_name,
                    style: mediumBold(darkBlue),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      query: AuthService().getMentors(),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }
}

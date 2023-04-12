import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/book_sheet.dart';
import 'package:career_paddy/components/users/interests.dart';
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
          child: GestureDetector(
            onTap: () => buildShowModalBottomSheet(context, user),
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  ProfileIcon(
                    image: user.photoURL,
                    radius: 50,
                    isExternal: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.first_name,
                        style: mediumBold(darkBlue),
                      ),
                      if (user.interests != null) ...[
                        SizedBox(
                          height: 3,
                        ),
                        UsersInterests(user: user),
                      ],
                      const SizedBox(
                        height: 3,
                      ),
                      Text(user.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      query: AuthService().getMentors(),
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
    BuildContext context,
    UserModel user,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
        ),
      ),
      context: context,
      builder: (_) => BookSheet(
        user: user,
      ),
    );
  }
}

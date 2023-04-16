import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/sessions/empty_mentee.dart';
import 'package:career_paddy/pages/sessions/session_ui.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sessions',style: mediumBold(primaryBlack),),
            Text('see all',style: mediumBold(primaryBlack),),
          ],
        ),
        SizedBox(height: 10,),
        PaginateFirestore(
          shrinkWrap: true,
          onEmpty: user.role == MENTEE
              ? const EmptyMentee()
              : Center(
                  child: Text('No sessions yet',style: medium(),),
                ),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, snapshots, index) {
            var snap = snapshots[index];
            var session = SessionModel.fromJson(
              snap.id,
              snap.data() as dynamic,
            );

            return SessionUI(session: session);
          },
          query: user.role == MENTOR
              ? SessionService.getMentorSessions(user.uid)
              : SessionService.getMenteeSessions(user.uid),
          itemBuilderType: PaginateBuilderType.listView,
        )
      ],
    );
  }
}
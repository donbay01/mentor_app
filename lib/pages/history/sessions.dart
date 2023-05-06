import 'package:career_paddy/constants/message.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import '../../helper/date.dart';
import '../../models/session_model.dart';
import '../../providers/user.dart';
import '../../services/session.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../notifications/stacked_avatar.dart';

class SessionsHistory extends StatelessWidget {
  const SessionsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
        title: Text(
          'Home',
          style: mediumText(primaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'History',
                style: mediumBold(primaryBlack),
              ),
              SizedBox(
                height: 10,
              ),
              PaginateFirestore(
                isLive: true,
                separator: SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemBuilder: (context, snapshots, index) {
                  var snap = snapshots[index];
                  var session = SessionModel.fromJson(
                    snap.id,
                    snap.data() as dynamic,
                  );

                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                StackedAvatars(
                                  mentorImage: session.mentorImage,
                                  menteeImage: session.menteeImage,
                                  height: 40,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'A call with ${session.mentee}',
                                  style: smallText(textGrey),
                                ),
                              ],
                            ),
                            Text(
                              '${DateHelper.formatShort(session.requestedAt.toDate())} | ${session.start} - ${session.end}',
                              style: smallText(textGrey),
                            ),
                          ],
                        ),
                        // Text(
                        //   '+500 pts',
                        //   style: smallText(Colors.green),
                        // ),
                      ],
                    ),
                  );
                },
                query: SessionService.getMenteeHistory(
                  user.uid,
                  CAREER_SESSION,
                ),
                itemBuilderType: PaginateBuilderType.listView,
                onEmpty: Center(
                  child: Text(
                    'No Career session',
                    style: medium(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

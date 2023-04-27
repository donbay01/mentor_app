import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/session.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class ManagePoints extends StatefulWidget {
  const ManagePoints({Key? key}) : super(key: key);

  @override
  State<ManagePoints> createState() => _ManagePointsState();
}

class _ManagePointsState extends State<ManagePoints> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;
    var size = MediaQuery.of(context).size;

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
              if (user.role == MENTOR) ...[
                Text(
                  'Manage account',
                  style: large(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bannerBlue.png'),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.coins,
                              color: primaryWhite,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Total Paddy Points',
                              style: smallBold(primaryWhite),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Text(
                          '${user.paddy_points}',
                          style: largeText(primaryWhite),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: primaryBlue,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '1 career section = 500 points',
                      style: smallText(primaryBlue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: size.height * 0.065,
                        width: size.width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: primaryBlue, width: 1),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Withdraw Points',
                                style: smallText(primaryBlue),
                              ),
                              Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: primaryBlue,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit Account',
                        style: smallText(primaryBlack),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
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

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image(image: AssetImage('assets/jointavi.png')),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${session.meetingType} with ${session.mentee}',
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
                      Text(
                        '+500 pts',
                        style: smallText(Colors.green),
                      ),
                    ],
                  );
                },
                query: SessionService.getHistory(user.uid),
                itemBuilderType: PaginateBuilderType.listView,
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

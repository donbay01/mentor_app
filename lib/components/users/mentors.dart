import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            onTap: () {
              buildShowModalBottomSheet(context);
            },
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
                        Row(
                          children: [
                            for (var i = 0;
                                i < user.interests!.length;
                                i++) ...[
                              Text(
                                '${user.interests![i].name}${i == user.interests!.length - 1 ? '' : ','} ',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ]
                          ],
                        ),
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

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),topRight: Radius.circular(80))),
      context: context,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // bannerandavatarvzW (80:759)
                margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                width: double.infinity,
                height: 182,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.17,
                      decoration: BoxDecoration(
                          color: secondaryBlue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 30,
                                color: primaryWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      // avatarxgJ (80:763)
                      left: 20,
                      top: 100,
                      child: Align(
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              'assets/adaptLogo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // frame2FfQ (80:764)
                margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // kokomabrownbUN (80:765)
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                      child: Text(
                        'Kokoma Brown',
                        style: mediumBold(primaryBlack),
                      ),
                    ),
                    Text(
                        // uxstrategistappletiN (80:766)
                        'UX Strategist, Apple',
                        style: small()),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // frame14hQv (80:768)
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // frame8f6r (80:769)
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      width: double.infinity,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Container(
                        // frame7AJW (80:770)
                        width: 309.17,
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame4He2 (80:771)
                              width: 99.67,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32),
                                ),
                              ),
                              child: Center(
                                child: Text('About', style: small()),
                              ),
                            ),
                            Container(
                              // autogroupf2uqNQa (YCGVEi9jV6xxDMT6izf2uQ)
                              padding: EdgeInsets.fromLTRB(43.83, 6, 0, 6),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // reviewsJZ8 (80:774)
                                    margin: EdgeInsets.fromLTRB(0, 0, 73.67, 0),
                                    child: Text(
                                      'Reviews',
                                      style: small(),
                                    ),
                                  ),
                                  Text(
                                      // articlesdLW (80:776)
                                      'Articles',
                                      style: small()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      // imsenioruxstrategistatapplewit (80:777)
                      constraints: BoxConstraints(
                        maxWidth: 319,
                      ),
                      child: Text(
                        'I’m  senior UX strategist at Apple with 12+ years of experience in the design industry. I help young professional navigate their career path with my level of expertise',
                        style: small(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Availability',
                      style: small(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('(this week)', style: small()),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: Text('Select one date you are comfortable with',
                    style: small()),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // frame186hv2 (80:786)
                margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                width: double.infinity,
                height: 75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // frame184Q3k (80:787)
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                      width: 103.67,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mon, 25th', style: small()),
                          Text(
                              // pm3pmp7U (80:789)
                              '2PM - 3PM',
                              style: small()),
                        ],
                      ),
                    ),
                    Container(
                      // frame185mHc (80:790)
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                      width: 103.67,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mon, 25th', style: small()),
                          Text(
                              // am11amoVC (80:792)
                              '10AM - 11AM',
                              style: small()),
                        ],
                      ),
                    ),
                    Container(
                      // frame1868nN (80:793)
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                      width: 103.67,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tue, 26th', style: small()),
                          Text(
                            // pm3pmCGS (80:795)
                            '2PM - 3PM',
                            style: small(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // frame188k34 (80:796)
                margin: EdgeInsets.only(
                  left: 16,
                ),
                width: double.infinity,
                height: 75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // frame184sNa (80:797)
                      margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                      width: 103,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fri, 29th', style: small()),
                          Text(
                              // pm8pmWRY (80:799)
                              '7PM - 8PM',
                              style: small()),
                        ],
                      ),
                    ),
                    Container(
                      // frame185rkJ (80:800)
                      padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                      width: 103,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfff2f3f6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sat, 30th', style: small()),
                          Text(
                              // pm1pmWpr (80:802)
                              '12PM - 1PM',
                              style: small()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      width:  MediaQuery.of(context).size.width * 0.45,
                      height:  MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeaecf0)),
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(child: Text('Cancel',style: medium(),)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width:  MediaQuery.of(context).size.width * 0.45,
                      height:  MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeaecf0)),
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(child: Text('Book Now',style: mediumText(primaryWhite),)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

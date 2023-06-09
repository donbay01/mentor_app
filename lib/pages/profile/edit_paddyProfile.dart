import 'dart:io';
import 'package:career_paddy/pages/profile/save_button.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/users/mentor_Personal.dart';
import '../../components/users/mentor_experience.dart';
import '../../components/users/mentor_socials.dart';
import '../../providers/user.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'avatar.dart';

class EditPaddyProfile extends StatefulWidget {
  final bool isNot;

  const EditPaddyProfile({
    Key? key,
    this.isNot = true,
  }) : super(key: key);

  @override
  State<EditPaddyProfile> createState() => _EditPaddyProfileState();
}

class _EditPaddyProfileState extends State<EditPaddyProfile>
    with TickerProviderStateMixin {
  var service = AuthService();
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var live = context.watch<UserProvider>().getUser;
    var user = service.getFirebaseUser()!;

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                if (widget.isNot) {
                  exit(0);
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: primaryBlack,
                size: 25,
              ),
            ),
            title: Text(
              'Complete Your Profile',
              style: TextStyle(color: primaryBlack, fontSize: 20),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: key,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileAvatar(
                        user: user,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Kindly provide us with the following information for verification',
                        style: medium(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                            indicatorColor: primaryBlue,
                            controller: _tabController,
                            unselectedLabelColor: textGrey,
                            labelColor: primaryBlue,
                            indicatorWeight: 2,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: smallBold(primaryBlue),
                            indicator: const UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 2,
                                color: primaryBlue,
                              ),
                            ),
                            tabs: [
                              Tab(
                                text: 'Personal',
                              ),
                              Tab(
                                text: 'Experience',
                              ),
                              Tab(
                                text: 'Social',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            MentorPersonal(
                              user: live,
                              formKey: key,
                            ),
                            MentorExperience(
                              user: live,
                              formKey: key,
                            ),
                            MentorSocial(
                              user: live,
                              formKey: key,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SaveButton(
            isNot: widget.isNot,
            formKey: key,
          ),
        ),
      ),
    );
  }
}

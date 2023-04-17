import 'package:career_paddy/components/users/mentor_Personal.dart';
import 'package:career_paddy/components/users/mentor_socials.dart';
import 'package:career_paddy/pages/profile/avatar.dart';
import 'package:career_paddy/pages/profile/save_button.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/users/mentor_experience.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  var service = AuthService();

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                          ),
                          // bookingsPage(filteredMentors: filteredMentors,height: height,width: width,),
                          MentorExperience(user: live),
                          MentorSocial(user: live),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SaveButton(),
      ),
    );
  }
}
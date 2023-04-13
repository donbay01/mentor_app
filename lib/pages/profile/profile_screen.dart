import 'package:awesome_select/awesome_select.dart';
import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/components/users/mentor_Personal.dart';
import 'package:career_paddy/components/users/mentor_socials.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/pages/profile/avatar.dart';
import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/users/mentor_experience.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  String? _gender;
  String? _employmentStatus;
  List<InterestModel> _interests = [], sel = [];
  TextEditingController _resume = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var service = AuthService();
  // bool isLoading = false;

  UploadTask? task;
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
  void didChangeDependencies() {
    _interests = context.watch<InterestProvider>().getInterests;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;
    var live = context.watch<UserProvider>().getUser;

    _gender = live.gender;
    _employmentStatus = live.employment;
    sel = live.interests ?? [];
    _resume.text = live.resume ?? '';

    return
      // isLoading ?
    Scaffold(
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
            // key: _formKey,
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
                      Text('Kindly provide us with the following information for verification',style: medium(),),
                      SizedBox(height: 20,),
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
                      SizedBox(height: 20,),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            MentorPersonal(),
                            // bookingsPage(filteredMentors: filteredMentors,height: height,width: width,),
                            MentorExperience(),
                            MentorSocial(),
                          ],
                        ),
                      )

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Text(
                      //         'Cancel',
                      //         style: mediumText(primaryBlack),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     ElevatedButton(
                      //       onPressed: () async {
                      //         setState(() {
                      //           // isLoading = true;
                      //         });
                      //         await service.updateProfile(
                      //           gender: _gender,
                      //           employment: _employmentStatus,
                      //           resume: _resume.text,
                      //           interests: sel.map((e) => e.name).toList(),
                      //         );
                      //         SnackBarHelper.displayToastMessage(
                      //           context,
                      //           'Updated profile',
                      //           primaryBlue,
                      //         );
                      //         Navigator.push(context, MaterialPageRoute(builder: (_)=>PaddyProfile()));
                      //         setState(() {
                      //           // isLoading = false;
                      //         });
                      //       },
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(10.0),
                      //         child: Text(
                      //           'Save Changes',
                      //           style: medium(),
                      //         ),
                      //       ),
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: primaryBlue,
                      //         shape: ContinuousRectangleBorder(
                      //           borderRadius: BorderRadius.circular(32),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
              ),
            ),
          ),
        ),
      bottomNavigationBar: buildSaveButton(),
    );
    // : Loader();
  }

  Widget buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(' Cancel',style: mediumText(primaryBlack),),
          ),style: ElevatedButton.styleFrom(
              backgroundColor: primaryWhite,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32))
          ),),
          SizedBox(width: 20,),
          ElevatedButton(onPressed: () async {
            setState(() {
              // isLoading = true;
            });
            await service.updateProfile(
              gender: _gender,
              employment: _employmentStatus,
              resume: _resume.text,
              interests: sel.map((e) => e.name).toList(),
            );
            SnackBarHelper.displayToastMessage(
              context,
              'Updated profile',
              primaryBlue,
            );
            Navigator.push(context, MaterialPageRoute(builder: (_)=>PaddyProfile()));
            setState(() {
              // isLoading = false;
            });
          }, child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(' Save Changes'),
          ),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryBlue,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32))
            ),
          ),

        ],
      ),
    );
  }
}

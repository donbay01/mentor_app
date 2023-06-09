import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/mentor_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/pages/profile/about.dart';
import 'package:career_paddy/pages/profile/availability/paddy.dart';
import 'package:career_paddy/pages/profile/services.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/role.dart';
import '../Become_paddy/BecomePaddy.dart';
import 'edit_paddyProfile.dart';

class PaddyProfile extends StatefulWidget {
  final UserModel? paddy;

  const PaddyProfile({
    Key? key,
    this.paddy,
  }) : super(key: key);

  @override
  State<PaddyProfile> createState() => _PaddyProfileState();
}

class _PaddyProfileState extends State<PaddyProfile> {
  bool _c = false, _m = false;
  var service = AuthService();

  launchLink(String url) => launchUrl(Uri.parse(url));

  @override
  void initState() {
    var a = context.read<UserProvider>();
    _m = a.isMockInterviewer ?? a.getUser.isMockInterviewer;
    _c = a.isCareerMentor ?? a.getUser.isCareerMentor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.paddy;
    var provider = context.watch<UserProvider>();

    if (widget.paddy == null) {
      user = provider.getUser;
    }
    var size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;

    var role = user!.role;
    var newRole = role == MENTOR ? MENTEE : MENTOR;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => Dashboard(),
                ),
                (route) => false,
              );
            },
            icon: Icon(
              FontAwesomeIcons.house,
              color: darkBlue,
              size: 20,
            ),
          ),
          title: Text(
            'Profile',
            style: TextStyle(color: primaryBlack, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileIcon(
                  image: user!.photoURL,
                  isExternal: true,
                  radius: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.68,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.first_name} ${user.last_name}',
                            style: large(),
                          ),
                          UsersInterests(
                            user: user,
                            style: smallText(textGrey),
                          ),
                        ],
                      ),
                    ),
                    if (widget.paddy == null) ...[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditPaddyProfile(
                                  isNot: false,
                                ),
                              ),
                            );
                            // if (user?.role == MENTOR) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => EditPaddyProfile(),
                            //     ),
                            //   );
                            // }
                            // else {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (_) => EditBuddyProfile(user: user!),
                            //     ),
                            //   );
                            // }
                          },
                          child: Text('Edit profile'),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                role == MENTOR
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const MentorAvailabilty(),
                            ),
                          );
                        },
                        child: Container(
                          height: size.height * 0.065,
                          width: size.width * 0.42,
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
                                Icon(
                                  FontAwesomeIcons.calendarCheck,
                                  size: 15,
                                  color: secondaryBlue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Set availability'),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => launchLink(user!.linkedin!),
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.4,
                        decoration: BoxDecoration(color: greyColor),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.linkedin,
                              color: textGrey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('LinkedIn profile'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () => launchLink(user!.resume!),
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.4,
                        decoration: BoxDecoration(color: greyColor),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.wordpress_rounded,
                              color: textGrey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'website',
                              style: smallText(textGrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (user.reviewed) ...[
                  TextButton(
                    onPressed: () async {
                      if (!user!.reviewed) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BecomePaddy(),
                          ),
                        );
                      } else {
                        String text;
                        text = newRole == MENTOR && user.reviewed
                            ? 'You are now a paddy'
                            : 'Your account will be reviewed soon';
                        try {
                          await ProgressService.show(context);
                          await AuthService.switchRole(newRole);
                          await ProgressService.hide();

                          return SnackBarHelper.displayToastMessage(
                            context,
                            newRole == MENTOR ? text : 'You are now a buddy',
                            primaryBlue,
                          );
                        } on FirebaseFunctionsException catch (e) {
                          await ProgressService.hide();
                          return SnackBarHelper.displayToastMessage(
                            context,
                            e.message!,
                            primaryBlue,
                          );
                        }
                      }
                    },
                    child: role == MENTOR
                        ? Text('Switch to Buddy Account')
                        : Text('Switch to Paddy Account'),
                  ),
                ] else ...[
                  if (user.role == MENTEE) ...[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BecomePaddy(),
                          ),
                        );
                      },
                      child: Text('Become a Paddy'),
                    ),
                  ] else ...[
                    TextButton(
                      onPressed: () async {
                        await ProgressService.show(context);
                        await AuthService.switchRole(newRole);
                        await ProgressService.hide();
                      },
                      child: Text('Become a Buddy'),
                    ),
                  ]
                ],

                // TextButton(
                //   onPressed: () async {
                //     try {
                //       await ProgressService.show(context);
                //       await AuthService.switchRole(newRole);
                //       await ProgressService.hide();
                //
                //       return SnackBarHelper.displayToastMessage(
                //         context,
                //         newRole == MENTOR
                //             ? 'Your account will be reviewed soon'
                //             : 'You are now a buddy',
                //         primaryBlue,
                //       );
                //     } on FirebaseFunctionsException catch (e) {
                //       await ProgressService.hide();
                //       return SnackBarHelper.displayToastMessage(
                //         context,
                //         e.message!,
                //         primaryBlue,
                //       );
                //     }
                //   },
                //   child: Text(
                //     'Request ${role == MENTOR ? 'Buddy' : 'Paddy'} account',
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                UserServices(
                  user: user,
                ),
                SizedBox(
                  height: 10,
                ),
                AboutProfile(
                  user: user,
                ),
                if (user.role == MENTOR) ...[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'I can help with',
                    style: mediumBold(textGrey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Career roadmap and advice',
                        style: smallText(textGrey),
                      ),
                      Checkbox(
                        value: _c,
                        onChanged: (val) {
                          _c = !_c;
                          provider.holdCareerMentor(val!);
                          service.updateField({
                            'isCareerMentor': _c,
                          });

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mock Interviews',
                        style: smallText(textGrey),
                      ),
                      Checkbox(
                        value: _m,
                        onChanged: (val) {
                          _m = !_m;
                          provider.holdMockInterview(val!);
                          service.updateField({
                            'isMockInterviewer': _m,
                          });

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

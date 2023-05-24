import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/pages/profile/about.dart';
import 'package:career_paddy/pages/profile/availability/paddy.dart';
import 'package:career_paddy/pages/profile/services.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/role.dart';
import 'edit_buddyProfile.dart';
import 'edit_paddyProfile.dart';

class PaddyProfile extends StatelessWidget {
  final UserModel? paddy;

  const PaddyProfile({
    Key? key,
    this.paddy,
  }) : super(key: key);

  launchLink(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    var user = paddy;
    if (paddy == null) {
      user = context.watch<UserProvider>().getUser;
    }
    var size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;

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
                    if (paddy == null) ...[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (user?.role == MENTOR) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditPaddyProfile(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditBuddyProfile(user: user!),
                                ),
                              );
                            }
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
                GestureDetector(
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
                ),
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
                TextButton(
                  onPressed: () {},
                  child: Text('Request Buddy account'),
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

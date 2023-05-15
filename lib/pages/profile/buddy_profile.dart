import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/drawer/profile_icon.dart';
import '../../components/users/interests.dart';
import '../../constants/role.dart';
import '../../providers/user.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../Dashboard/dashboard_screen.dart';
import 'edit_buddyProfile.dart';
import 'edit_paddyProfile.dart';

class BuddyProfile extends StatelessWidget {
  final UserModel? buddy;

  const BuddyProfile({
    Key? key,
    this.buddy,
  }) : super(key: key);

  launchLink(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    var user = buddy;
    if (buddy == null) {
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
                  image: user?.photoURL,
                  isExternal: true,
                  radius: 70,
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
                            '${user?.first_name} ${user?.last_name}',
                            style: large(),
                          ),
                          UsersInterests(
                            user: user!,
                            style: smallText(textGrey),
                          ),
                        ],
                      ),
                    ),
                    if (buddy == null) ...[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (user!.role == MENTOR) {
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
                Row(
                  children: [
                    Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(color: greyColor),
                      child: Center(
                        child: Text(
                          user.gender ?? 'No gender set',
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
                        width: width * 0.3,
                        decoration: BoxDecoration(color: greyColor),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.attach_file_outlined,
                              color: textGrey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Resume',
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
                Text(
                  'About me',
                  style: mediumBold(primaryBlack),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.bio ?? 'No bio yet',
                  style: small(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Personal info',
                  style: mediumBold(primaryBlack),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E-mail',
                      style: mediumText(textGrey),
                    ),
                    Text(
                      user.email,
                      style: mediumText(primaryBlack),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mobile',
                      style: mediumText(textGrey),
                    ),
                    Text(
                      user.phoneNumber!,
                      style: mediumText(primaryBlack),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Industry',
                  style: mediumBold(primaryBlack),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(color: greyColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UsersInterests(
                      user: user,
                      style: smallText(textGrey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

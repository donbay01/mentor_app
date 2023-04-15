import 'package:career_paddy/pages/profile/about.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/drawer/profile_icon.dart';
import '../../components/users/interests.dart';
import '../../providers/user.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../Dashboard/dashboard_screen.dart';

class BuddyProfile extends StatelessWidget {
  const BuddyProfile({Key? key}) : super(key: key);

  launchLink(String url) => launchUrl(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;
    var size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=> Dashboard()));
          },
          icon: Icon(
            FontAwesomeIcons.homeUser,
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
                image: user.photoURL,
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
                          '${user.first_name} ${user.last_name}',
                          style: bold(),
                        ),
                        UsersInterests(
                          user: user,
                          style: smallText(textGrey),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProfilePage(),
                        ),
                      );
                    },
                    child: Text('Edit profile'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                Container(
                  height: height * 0.05,
                  width: width * 0.35,
                  decoration: BoxDecoration(color: greyColor),
                  child: Center(child: Text('Male')),
                ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: () => launchLink(user.resume!),
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
              ],),
              SizedBox(
                height: 20,
              ),
              AboutProfile(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

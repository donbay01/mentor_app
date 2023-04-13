import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/pages/profile/about.dart';
import 'package:career_paddy/pages/profile/availability/paddy.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/pages/profile/services.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PaddyProfile extends StatelessWidget {
  const PaddyProfile({Key? key}) : super(key: key);

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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryBlack,
            size: 25,
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
                radius: 90,
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
                          style: mediumText(textGrey),
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
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: primaryBlue, width: 1),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
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
                    onTap: () => launchLink(user.linkedin!),
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.35,
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
                            FontAwesomeIcons.internetExplorer,
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
                height: 10,
              ),
              UserServices(),
              SizedBox(
                height: 10,
              ),
              AboutProfile(),
            ],
          ),
        ),
      ),
    );
  }
}

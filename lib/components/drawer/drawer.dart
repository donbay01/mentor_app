import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/pages/Become_paddy/BecomePaddy.dart';
import 'package:career_paddy/pages/contact/contact_us.dart';
import 'package:career_paddy/pages/home/manage_points.dart';
import 'package:career_paddy/pages/payment/payment_screen.dart';
import 'package:career_paddy/pages/profile/edit_paddyProfile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/link.service.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../pages/profile/paddy_profile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().user;

    return SizedBox(
      height: size.height * 0.85,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (user != null) ...[
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaddyProfile(),
                        ),
                      );
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.transparent),
                      accountName: Text(
                        '${user.first_name} ${user.last_name}',
                        style: mediumBold(primaryBlack),
                      ),
                      accountEmail: GestureDetector(
                        onTap: () {
                          // var role = user.role;
                          Widget route = PaddyProfile();
                          // if (role == MENTOR) {
                          //   route = EditPaddyProfile();
                          // } else {
                          //   route = EditBuddyProfile(user: user);
                          // }

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => route,
                            ),
                          );
                        },
                        child: Text(
                          'View Profile',
                          style: TextStyle(
                            color: primaryBlue,
                          ),
                        ),
                      ),
                      // accountEmail: Text(
                      //   user.email,
                      //   style: smallText(primaryBlack),
                      // ),
                      currentAccountPicture: ProfileIcon(
                        isExternal: true,
                        image: user.photoURL,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.payment,
                      color: primaryBlue,
                    ),
                    title: Text(
                      'Manage account',
                      style: medium(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (user.role == MENTOR) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ManagePoints(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionPage(
                              user: user,
                            ),
                          ),
                        );
                      } // close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.key,
                      size: 20,
                      color: primaryBlue,
                    ),
                    title: Text(
                      'Account and Privacy',
                      style: medium(),
                    ),
                    onTap: () {
                      launchUrlString(
                        'https://careerpaddy.co/privacy-policy',
                        mode: LaunchMode.inAppWebView,
                      );
                      // close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  if (user.role == MENTEE) ...[
                    ListTile(
                      leading: Icon(
                        Icons.people_alt_sharp,
                        color: primaryBlue,
                      ),
                      title: Text(
                        user.reviewed ? 'Switch to a Paddy' : 'Become a Paddy',
                        style: medium(),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BecomePaddy(),
                          ),
                        );
                        // Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ],
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.personCirclePlus,
                      color: primaryBlue,
                    ),
                    title: Text(
                      'Invite to career Paddy',
                      style: medium(),
                    ),
                    onTap: () async {
                      final urlLink = await LinkService.buildLink();

                      await Share.share(
                        'Download the Career Paddy app and learn from industry experts.\n$urlLink',
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: primaryBlue,
                    ),
                    title: Text(
                      'Help and Support',
                      style: medium(),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ContactUs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Log Out',
                      style: mediumText(Colors.red),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(
                            'Are you sure you want to log out?',
                            style: medium(),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  context.read<UserProvider>().cancel();
                                  await AuthService().logout();
                                  await Navigator.of(context)
                                      .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (ctx) => LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Text(
                                  'Yes',
                                  style: mediumText(primaryBlue),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No',
                                  style: mediumText(primaryBlack),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../pages/profile/buddy_profile.dart';
import '../../pages/profile/paddy_profile.dart';

class MyDrawer extends StatelessWidget {
  final User user;

  const MyDrawer({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().getUser;

    return SizedBox(
      height: size.height * 0.65,
      child: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: secondaryBlue),
              accountName: Text('${user.first_name} ${user.last_name}'),
              accountEmail: Text(user.email!),
              currentAccountPicture: ProfileIcon(),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              subtitle: Text('View your profile'),
              onTap: () {
                Navigator.pop(context);
                if (user.role == MENTOR) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaddyProfile(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BuddyProfile(),
                    ),
                  );
                }
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              subtitle: Text('edit your settings'),
              onTap: () {
                Navigator.pop(context); // close drawer
                // Navigator.pushNamed(context, '/settings');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(FontAwesomeIcons.share),
              title: Text('Share'),
              subtitle: Text('Share the App'),
              onTap: () {
                Navigator.pop(context); // close drawer
                // Navigator.pushNamed(context, '/settings');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
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
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (ctx) => LoginScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          child: Text('Yes'),
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
          ],
        ),
      ),
    );
  }
}

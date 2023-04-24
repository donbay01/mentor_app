import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/pages/home/manage_points.dart';
import 'package:career_paddy/pages/payment/payment_screen.dart';
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
                  GestureDetector(
                    onTap: (){
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
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.transparent),
                      accountName: Text('${user!.first_name} ${user.last_name}',style: mediumBold(primaryBlack),),
                      accountEmail: Text(user.email,style: smallText(primaryBlack),),
                      currentAccountPicture: ProfileIcon(),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Manage account',style: medium(),),
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
                            builder: (_) => SubscriptionPage(),
                          ),
                        );
                      }// close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.key,size: 20,),
                    title: Text('Account and Privacy',style: medium(),),
                    onTap: () {
                      Navigator.pop(context); // close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.personCirclePlus,color: primaryBlue,),
                    title: Text('Invite to career Paddy',style: medium(),),
                    onTap: () {
                      Navigator.pop(context); // close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                ],
              ),


              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('Help and Support',style: medium(),),
                    onTap: () {
                      Navigator.pop(context); // close drawer
                      // Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout,color: Colors.red,),
                    title: Text('Log Out',style: mediumText(Colors.red),),
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
                                  await Navigator.of(context).pushAndRemoveUntil(
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
                  SizedBox(height: 30,)
                ],
              ),

            ],
          ],
        ),
      ),
    );
  }
}

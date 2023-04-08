import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Kokoma'),
            accountEmail: Text('kokoma@paddie.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/adaptLogo.png'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            subtitle: Text('Edit your profile'),
            onTap: () {
              Navigator.pop(context); // close drawer
              Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage()));
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
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            subtitle: Text('Check your notifications'),
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
              // log out functionality here
            },
          ),
        ],
      ),
    );
  }
}

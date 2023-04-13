import 'package:career_paddy/components/users/interests.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class BuddyProfile extends StatelessWidget {
  const BuddyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().getUser;

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
              CircleAvatar(
                backgroundImage: AssetImage('assets/adaptLogo.png'),
                radius: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .68,
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
                        )
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
            ],
          ),
        ),
      ),
    );
  }
}

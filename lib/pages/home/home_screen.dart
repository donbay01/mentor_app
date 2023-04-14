import 'package:career_paddy/components/banners/small.dart';
import 'package:career_paddy/components/drawer/drawer.dart';
import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/pages/notifications/notifications.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  var service = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;

    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(
          user: user,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, ${user.displayName!.split(' ').first}",
                      style: largeText(primaryBlack),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Notifications(),
                              ),
                            );
                          },
                          icon: Icon(Icons.notifications),
                        ),
                        GestureDetector(
                          onTap: () {
                            // scaffoldKey.currentState?.openDrawer();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyDrawer(user: user),
                              ),
                            );
                          },
                          child: ProfileIcon(
                            radius: 40,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SmallBanners(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/greenBox.png'),),
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(FontAwesomeIcons.coins,color: Colors.green,),
                                  SizedBox(width: 10,),
                                  Text(' Paddy Points',style: mediumBold(Colors.green),)
                                ],
                              ), Text('2000',style: large(),)
                            ],
                          ),
                        ),
                      ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/blueBox.png'),),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.people_alt,color: Colors.blue,),
                                SizedBox(width: 10,),
                                Text(' Total Sessions',style: mediumBold(Colors.blue),)
                              ],
                            ), Text('10',style: large(),)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/noBookings.svg',
                      height: 150,
                      width: 150,
                      // fit: BoxFit.cover,
                    ),
                    Text('You have not booked any sessions yet.'),
                    SizedBox(height: 10,),
                    Text('Start booking now!',style: smallBold(primaryBlue),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

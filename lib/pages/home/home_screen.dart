import 'package:career_paddy/components/drawer/drawer.dart';
import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hi Kokoma",style: largeText(primaryBlack),),
                      Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
                          GestureDetector(
                            onTap: (){
                              // scaffoldKey.currentState?.openDrawer();
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>MyDrawer()));
                            },
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/adaptLogo.png'),
                              radius: 23,
                            ),
                          )
                        ],
                      ),
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

import 'package:career_paddy/pages/profile/profile_screen.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaddyProfile extends StatefulWidget {
  const PaddyProfile({Key? key}) : super(key: key);

  @override
  State<PaddyProfile> createState() => _PaddyProfileState();
}

class _PaddyProfileState extends State<PaddyProfile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Mentors Information
                      Text('Chibuike Nwani',style: large(),),
                      Text('Ux Strategist, Apple',style: mediumText(textGrey),)
                    ],
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfilePage()));
                    }, child: Text('Edit profile')),

                ],
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                //  This will lead to the My Sessions that has the Calendar Screen. If you don't understand Call me
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: primaryBlue,width: 1),color: Colors.transparent
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.calendarCheck,size: 15,color: secondaryBlue,),
                        SizedBox(width: 10,),
                        Text('Set availability'),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.35,
                    decoration: BoxDecoration(
                      color: greyColor
                    ),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.linkedin,color: textGrey,),
                        SizedBox(width: 10,),
                        Text('LinkedIn profile'),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      color: greyColor
                    ),
                    child: Row(

                      children: [
                        SizedBox(width: 5,),
                        Icon(FontAwesomeIcons.internetExplorer,color: textGrey,),SizedBox(width: 10,),
                        Text('website',style: smallText(textGrey),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('Services',style: mediumBold(textGrey),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                        color: greyColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Services of mentor
                        Text('Ux research',style: smallText(greyText),),
                      ],
                    ),
                  ),
                  // SizedBox(width: 20,),
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: greyColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('UI Design',style: smallText(greyText),),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: greyColor
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Problem solving',style: smallText(greyText),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text('About me',style: mediumBold(textGrey),),
              SizedBox(height: 10,),
              Text('Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. Dignissim sit sem mattis aliquet ut sapien mattis aliquet adipiscing.'
              ,style: mediumText(textGrey),),
              SizedBox(height: 20,),
              //Job Experiences
              Text('Experience',style: mediumBold(textGrey),),
              SizedBox(height: 10,),
              Text('Ux Strategist',style: mediumBold(textGrey),),
              SizedBox(height: 5,),
              Text('Apple',style: smallText(textGrey),),
              SizedBox(height: 5,),
              Text('Sept 2021 - present',style: smallText(textGrey),),
              SizedBox(height: 10,),
              Text('Ux Researcher',style: mediumBold(textGrey),),
              SizedBox(height: 5,),
              Text('Layers',style: smallText(textGrey),),
              SizedBox(height: 5,),
              Text('Jan 2021 - August 2021',style: smallText(textGrey),),
              SizedBox(height: 10,),
              Text('UI Designer',style: mediumBold(textGrey),),
              SizedBox(height: 5,),
              Text('carli',style: smallText(textGrey),),
              SizedBox(height: 5,),
              Text('Jan 2021 - August 2021',style: smallText(textGrey),),
              SizedBox(height: 20,),
              Text('I can help with',style: mediumBold(textGrey),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Career roadmap and advice',style: smallText(textGrey),),
                  Icon(Icons.check_circle,color: Colors.green,size: 15,)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mock Interviews',style: smallText(textGrey),),
                  Icon(Icons.check_circle,color: Colors.green,size: 15,)
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}

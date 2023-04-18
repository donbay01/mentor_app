import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nav = context.read<BottomNavProvider>();
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Learning',
          style: mediumText(primaryBlue),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
          onPressed: () {
            // nav.setIndex(2);
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Effective Communication',
                style: largeText(primaryBlack),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/course.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'About the course',
                style: mediumBold(darkBlue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. Dignissim sit sem mattis aliquet ut sapien mattis aliquet adipiscing.',
                style: mediumText(textGrey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextButton(onPressed: () {}, child: Text('Show all')),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Skills to gain',
                style: mediumBold(darkBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Emotional Intelligence',style: mediumText(textGrey),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Anger Management',style: mediumText(textGrey),),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Psychology',style: mediumText(textGrey),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Course outline',
                style: mediumBold(primaryBlack),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/learn.png'
                      ),
                    )
                ),
              ),
              title: Text("Introduction to Emotional Intelligence"),
              subtitle: Text("Lesson 1"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> CourseDetails()));
              },
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/course.png'
                      ),
                    )
                ),
              ),
              title: Text("Always Speak Last"),
              subtitle: Text("Lesson 2"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> CourseDetails()));
              },
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/adaptLogo.png'
                      ),
                    )
                ),
              ),
              title: Text("The Impact of Patience"),
              subtitle: Text("Lesson 3"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> CourseDetails()));
              },
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: primaryBlue,
          ),
          child: Center(child: Text('Enroll Now',style: mediumBold(primaryWhite),)),
        ),
      ),
    );
  }
}

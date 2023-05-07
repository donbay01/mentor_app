import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/course_outline.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';

import '../../theme/text_style.dart';

class LessonPage extends StatelessWidget {
  // final CourseModel course;
  const LessonPage({Key? key,
    // required this.course
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
        title: Text(
          'New Course',
          style: mediumText(primaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage('assets/course.png'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('LESSON 1',style: mediumBold(primaryBlack),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Introduction to Time Management',style: mediumBold(primaryBlack),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(child: Text('Lorem ipsum dolor sit amet consectetur. Tristique magna feugiat vulputate urna. Commodo ullamcorper commodo in et etiam. Nisl malesuada laoreet praesent pellentesque nibh eget sit quam est. Nunc ipsum fringilla sodales tellus scelerisque faucibus amet dolor. Eget at dictumst volutpat risus id ipsum volutpat. Elementum purus sed odio erat sit. Turpis elementum nisi ac semper sem adipiscing egestas facilisis. Vitae cum suscipit posuere scelerisque. Molestie sagittis mollis amet vel eget magna quis tortor. Massa etiam turpis morbi viverra nunc in aliquam. Aliquam urna lectus ut lectus sodales. Pellentesque tristique semper consectetur porta. Lobortis justo pretium ornare odio. Non vel id maecenas vitae neque nisl porta elit egestas. Nisl dignissim nec tempus facilisi augue tellus. Dui fringilla urna adipiscing dictum ut laoreet nibh aenean. Vestibulum porttitor nunc egestas a diam ut nullam nunc. Scelerisque amet lobortis sit sed sapien leo. Et nibh tortor consequat purus in quis aenean.',style: mediumText(textGrey),)),
            ),
            SizedBox(height: 10,),
            Center(child: TextButton(onPressed: (){}, child: Text('Next Lesson',style: mediumBold(primaryBlue),))),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}

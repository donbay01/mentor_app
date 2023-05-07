import 'package:career_paddy/pages/community/new_post.dart';
import 'package:career_paddy/pages/learn/lession_page.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../components/autocomplete/course.dart';
import '../../constants/role.dart';
import '../../models/course_model.dart';
import '../../models/user_model.dart';
import '../../theme/text_style.dart';
import 'add_course.dart';
import 'course_list.dart';

class OngoingCourse extends StatelessWidget {
  const OngoingCourse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Learning",
                    style: largeText(primaryBlack),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enroll in one of our courses",
                    style: mediumText(textGrey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutocompleteCourseSearch(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Ongoing Courses',
                    style: mediumBold(primaryBlack),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LessonPage()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.37,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: greyText.withOpacity(0.2))),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                  image: DecorationImage(
                                      image: AssetImage('assets/course.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Introduction to Money Making',
                                style: mediumBold(primaryBlack),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'By Ebuka Ekwenem',
                                style: smallText(textGrey),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '25%',
                                    style: medium(),
                                  ),
                                  Text(
                                    '4/20 lessons',
                                    style: smallText(textGrey),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.008,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    boxShadow: [],
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        colors: [
                                          primaryBlue,
                                          searchGrey,
                                          searchGrey,
                                          searchGrey,
                                          searchGrey,
                                        ])),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Explore Course',
                    style: mediumBold(primaryBlack),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  PaginateFirestore(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    isLive: true,
                    itemsPerPage: 10,
                    itemBuilder: (context, snapshots, index) {
                      var snap = snapshots[index];
                      var course = CourseModel.fromJson(
                        snap.id,
                        snap.data() as dynamic,
                      );

                      return CourseListUI(
                        course: course,
                      );
                    },
                    query: CourseService.getCourses(),
                    itemBuilderType: PaginateBuilderType.listView,
                    separator: const SizedBox(
                      height: 10,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton:  FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddCourse(),
              ),
            );
          },
          child: Icon(Icons.chat),
          backgroundColor: primaryBlue,
        )
      ),
    );
  }
}

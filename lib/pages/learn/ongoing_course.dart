import 'package:career_paddy/pages/learn/my_courses.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

import '../../components/autocomplete/course.dart';
import '../../models/course_model.dart';
import '../../theme/text_style.dart';
import 'add_course.dart';
import 'course_list.dart';

class OngoingCourse extends StatelessWidget {
  const OngoingCourse({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
                  MyCourses(),
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
        floatingActionButton: user.isAdmin
            ? FloatingActionButton(
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
            : null,
      ),
    );
  }
}

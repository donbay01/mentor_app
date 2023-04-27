import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/course_list.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../components/autocomplete/course.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CourseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore Course',
                      style: mediumBold(primaryBlack),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('See All'),
                    ),
                  ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

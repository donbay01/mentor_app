import 'package:career_paddy/components/input/textfield.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/add_image.dart';
import 'package:career_paddy/pages/learn/add_lesson.dart';
import 'package:career_paddy/pages/learn/course_details.dart';
import 'package:career_paddy/pages/learn/course_outline.dart';
import 'package:career_paddy/providers/course.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:listtextfield/listtextfield.dart';
import 'package:provider/provider.dart';
import '../../models/lesson_model.dart';
import '../../theme/text_style.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  var courseTittleController = TextEditingController();
  var courseShortDescriptionController = TextEditingController();
  final skillsController = ListTextEditingController(',');

  Future<CourseModel> createCourse(List<LessonModel> outlines) async {
    var user = context.read<UserProvider>().getUser;
    var task = context.read<CourseProvider>().task;

    var course = CourseModel(
      name: courseTittleController.text,
      about: courseShortDescriptionController.text,
      author: '${user.first_name} ${user.last_name}',
      authorUid: user.uid,
      image: await task!.snapshot.ref.getDownloadURL(),
      outlines: outlines,
      skills: skillsController.items,
    );

    return course;
  }

  @override
  void dispose() {
    courseTittleController.dispose();
    courseShortDescriptionController.dispose();
    skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<CourseProvider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Course Title',
                  controller: courseTittleController,
                  hint: 'Course title',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: 'Short Description (100 words)',
                  controller: courseShortDescriptionController,
                  minLines: 3,
                  maxLines: 4,
                  maxLength: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Skills to Gain (Separate with a comma)',
                  style: smallBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTextField(
                  controller: skillsController,
                  itemBuilder: (_, value) {
                    return Chip(
                      label: Text(value),
                      onDeleted: () => skillsController.removeItem(value),
                    );
                  },
                  itemSpacing: 8,
                  itemLineSpacing: 4,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AddImage(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Course Outline',
                  style: smallBold(textGrey),
                ),
                SizedBox(
                  height: 20,
                ),
                CourseOutline(outlines: prov.lessons),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    var res = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddLesson(
                          courseName: courseTittleController.text,
                        ),
                      ),
                    );
                    if (res != null) {
                      prov.addLesson(res);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: primaryBlue,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: primaryBlue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Add Lesson',
                            style: mediumText(primaryBlue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  var course = await createCourse(prov.lessons);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CourseDetails(
                        course: course,
                        isPreview: true,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Preview',
                    style: mediumBold(primaryBlack),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryWhite,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  var course = await createCourse(prov.lessons);
                  await CourseService.addCourse(course);
                  prov.clear();
                  Navigator.of(context).pop();

                  SnackBarHelper.displayToastMessage(
                    context,
                    'Course Created',
                    primaryBlue,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Add course',
                    style: mediumBold(primaryWhite),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/course_details.dart';
import 'package:career_paddy/providers/course.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    var c = context.read<CourseProvider>().myCourses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (c.length > 0) ...[
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
        ],
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(
              c.length,
              (index) => UI(
                course: c[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UI extends StatefulWidget {
  final CourseModel course;

  const UI({
    super.key,
    required this.course,
  });

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  int progress = 0;

  @override
  void initState() {
    CourseService().getProgress(widget.course.courseId!).then((value) {
      setState(() {
        progress = value.count;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var perc = ((progress / widget.course.outlines.length) * 100);

    return SizedBox(
      height: size.height / 2.7,
      width: size.width / 1.12,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetails(
                course: widget.course,
              ),
            ),
          );
        },
        child: Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 1,
              color: greyText.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.2,
                  imageUrl: widget.course.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.course.name,
                  style: mediumBold(primaryBlack),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.course.author,
                  style: smallText(textGrey),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$perc %',
                      style: medium(),
                    ),
                    Text(
                      '${progress}/${widget.course.outlines.length} lessons',
                      style: smallText(textGrey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: LinearProgressIndicator(
                  value: perc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../components/autocomplete/search.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class Course {
  final String title;
  final String author;
  final String image;
  final int enrolled;
  final int rating;

  Course({required this.title, required this.author, required this.image,
  required this.enrolled, required this.rating
  });
}

class CourseList extends StatelessWidget {
  final List<Course> courses = [
    Course(
        title: "Introduction to Computer Science",
        author: 'Samson Udo',
        image: "assets/learn.png",
        enrolled: 20,
        rating: 10

    ),
    Course(
        title: "Mobile App Development",
        author: 'Isaac John',
        enrolled: 20,
        rating: 10,
        image:
        "assets/course.png"),
    Course(
        title: "Data Science",
        author: 'Ebuka Ekwenem',
        image:
        "assets/learn.png",
        enrolled: 20,
        rating: 10
    ),
    Course(
        title: "Introduction to Computer Science",
        author: 'Chibuike Henry',
        enrolled: 20,
        rating: 10,
        image:
        "assets/course.png"),
    Course(
        title: "Mobile App Development",
        author: 'Kokoma Brown',
        enrolled: 20,
        rating: 10,
        image:
        "assets/learn.png"),    Course(
        title: "Data Science",
        author: 'Ebuka Ekwenem',
        image:
        "assets/learn.png",
        enrolled: 20,
        rating: 10
    ),
    Course(
        title: "Introduction to Computer Science",
        author: 'Chibuike Henry',
        enrolled: 20,
        rating: 10,
        image:
        "assets/course.png"),
    Course(
        title: "Mobile App Development",
        author: 'Kokoma Brown',
        enrolled: 20,
        rating: 10,
        image:
        "assets/learn.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                    AutocompleteSearch(),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Explore Course',style: mediumBold(primaryBlack),),
                      TextButton(onPressed: (){}, child: Text('See All'))
                    ],),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: courses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 64,
                                    width: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            courses[index].image
                                        ),
                                      )
                                    ),
                                  ),
                                  title: Text(courses[index].title),
                                  subtitle: Text("By ${courses[index].author}"),
                                  onTap: (){},
                                ),
                                Divider(
                                  color: darkBlue,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}

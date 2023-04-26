import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/pages/learn/course_details.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../theme/color.dart';

class AutocompleteCourseSearch extends StatefulWidget {
  const AutocompleteCourseSearch({super.key});

  @override
  State<AutocompleteCourseSearch> createState() =>
      _AutocompleteCourseSearchState();
}

class _AutocompleteCourseSearchState extends State<AutocompleteCourseSearch> {
  var service = CourseService();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic),
        decoration: InputDecoration(
          labelText: 'Search ...',
          hintText: 'course',
          filled: true,
          fillColor: searchColor,
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: darkBlue,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 1.0,
            ),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return <CourseModel>[];
        }

        var res = await service.search(pattern);
        var data = res.docs.map((e) => CourseModel.fromJson(e.id, e.data()));
        return data;
      },
      itemBuilder: (context, suggestion) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              ProfileIcon(
                image: suggestion.image,
                isExternal: true,
                radius: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${suggestion.name}'),
                  Text(suggestion.about),
                ],
              ),
            ],
          ),
        );
      },
      onSuggestionSelected: (suggestion) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => CourseDetails(course: suggestion),
        ),
      ),
    );
  }
}

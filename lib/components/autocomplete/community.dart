import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/helper/currency.dart';
import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/models/course_model.dart';
import 'package:career_paddy/models/job_model.dart';
import 'package:career_paddy/pages/community/job_details.dart';
import 'package:career_paddy/pages/learn/course_details.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/services/community.dart';
import 'package:career_paddy/services/courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../pages/community/post_details.dart';
import '../../theme/color.dart';

class AutocompleteCommunitySearch extends StatefulWidget {
  const AutocompleteCommunitySearch({super.key});

  @override
  State<AutocompleteCommunitySearch> createState() =>
      _AutocompleteCourseSearchState();
}

class _AutocompleteCourseSearchState
    extends State<AutocompleteCommunitySearch> {
  var service = CommunityService();

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
          hintText: 'Search keyword',
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
          return [];
        }

        var res = await service.search(pattern);
        var data = res.docs.map((e) {
          var type = e.get('type');
          if (type == 'jobs') {
            return JobModel.fromJson(e.data());
          }

          return Article.fromJson(e.data());
        });
        return data;
      },
      itemBuilder: (context, dynamic suggestion) {
        if (suggestion is JobModel) {
          return ListTile(
            title: Text(suggestion.role),
            subtitle: Text(
              '\$${CurrencyHelper.format(suggestion.minPay.toDouble())} - \$${CurrencyHelper.format(suggestion.maxPay.toDouble())}',
            ),
          );
        } else if (suggestion is Article) {
          return ListTile(
            title: Text(suggestion.title),
            subtitle: Text(suggestion.description),
          );
        }

        return ListTile(
          title: Text('a'),
          subtitle: Text('b'),
        );
      },
      onSuggestionSelected: (suggestion) {
        if (suggestion is JobModel) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => JobDetailsPage(job: suggestion),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ArticleDetailsPage(
                article: suggestion as Article,
              ),
            ),
          );
        }
      },
    );
  }
}

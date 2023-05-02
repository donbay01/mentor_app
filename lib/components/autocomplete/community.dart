import 'package:career_paddy/helper/currency.dart';
import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/models/job_model.dart';
import 'package:career_paddy/pages/community/job_details.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/services/community.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import '../../pages/community/post_details.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class AutocompleteCommunitySearch extends StatefulWidget {
  const AutocompleteCommunitySearch({super.key});

  @override
  State<AutocompleteCommunitySearch> createState() =>
      _AutocompleteCourseSearchState();
}

class _AutocompleteCourseSearchState
    extends State<AutocompleteCommunitySearch> {
  var service = CommunityService();
  var controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<BottomNavProvider>();

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Search ...',
          hintText: 'Search for Jobs',
          labelStyle: smallText(searchGrey),
          hintStyle: small(),
          filled: true,
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () => controller.clear(),
                  child: Icon(Icons.close),
                )
              : null,
          fillColor: searchColor,
          prefixIcon: Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(
              color: searchGrey,
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
        var type = prov.tab;
        if (pattern.isEmpty) {
          return [];
        }

        var res = await service.search(type, pattern);
        var data = res.docs.map((e) {
          var type = e.get('type');
          if (type == 'jobs') {
            return JobModel.fromJson(e.data());
          }

          return Article.fromJson(e.id, e.data());
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

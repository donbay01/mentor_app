import 'package:career_paddy/components/autocomplete/search.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../../components/book_mentor.dart';
import '../../components/users/career_mentor.dart';
import '../../components/users/mock_interviewers.dart';
import '../../models/mentor_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore",
                    style: largeText(darkGrey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Connect with other career paddies",
                    style: mediumText(textGrey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AutocompleteSearch(),
                  SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    indicatorColor: primaryBlue,
                    controller: _tabController,
                    unselectedLabelColor: textGrey,
                    labelColor: primaryBlue,
                    indicatorWeight: 2,
                    labelStyle: smallBold(primaryBlue),
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 2,
                        color: primaryBlue,
                      ),
                    ),
                    tabs: [
                      Tab(
                        text: 'Career mentorship',
                      ),
                      Tab(
                        text: 'Mock Interview',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        CareerMentors(),
                        MockInterviewers(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

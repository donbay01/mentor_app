import 'package:career_paddy/components/autocomplete/search.dart';
import 'package:career_paddy/components/users/mentors.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../../components/book_mentor.dart';
import '../../models/mentor_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  final List<Mentor> mentors = [
    Mentor('Kokoma', 'Product manager', 'assets/adaptLogo.png', 5, ''),
    Mentor('Chubby', 'E-Learning expert', 'assets/adaptLogo.png', 5, ''),
    Mentor('Isaac', 'UI/UX designer', 'assets/adaptLogo.png', 5, ''),
    Mentor('Ebuka', 'Soft Developer', 'assets/adaptLogo.png', 5, ''),
    Mentor('Joshua', 'Automobiles technician', 'assets/adaptLogo.png', 5, ''),
  ];

  List<Mentor> filteredMentors = [];
  List<Mentor> jobFilter = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                    indicatorSize: TabBarIndicatorSize.label,
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
                        MentorsList(),
                        // bookingsPage(filteredMentors: filteredMentors,height: height,width: width,),
                        bookingsPage(
                          filteredMentors: filteredMentors,
                          height: height,
                          width: width,
                        ),
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

class bookingsPage extends StatelessWidget {
  final double height, width;
  const bookingsPage({
    super.key,
    required this.filteredMentors,
    required this.height,
    required this.width,
  });

  final List<Mentor> filteredMentors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredMentors.length,
      itemBuilder: (context, index) {
        final mentor = filteredMentors[index];
        return Column(
          children: [
            ListTile(
              leading: Image(
                image: AssetImage(mentor.image),
              ),
              title: Text(
                mentor.name,
                style: mediumBold(darkBlue),
              ),
              subtitle: Text(mentor.description),
            ),
            Divider(
              height: 2,
            )
          ],
        );
      },
    );
  }
}

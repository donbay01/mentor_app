import 'package:career_paddy/components/autocomplete/search.dart';
import 'package:career_paddy/pages/sessions/call_sheet.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../../components/users/career_mentor.dart';
import '../../components/users/mock_interviewers.dart';

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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: AutocompleteSearch()),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                showDragHandle: true,
                                context: context,
                                builder: (_) => SortFilter(),
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100))));
                          },
                          icon: Icon(Icons.filter_list_sharp))
                    ],
                  ),
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

Widget SortFilter() {
  String? _gender;
  String? _industry;
  String? _jobRole;

  return SingleChildScrollView(
    child: Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filter',
                  style: mediumBold(primaryBlack),
                )),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: textGrey),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
              ),
              hint: Text('Industry', style: mediumText(textGrey)),
              value: _industry,
              items: ['Banking', 'Technology', 'FinTech', 'Agriculture']
                  .map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: mediumText(textGrey),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _industry = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
              ),
              hint: Text(
                'Job Role',
                style: mediumText(textGrey),
              ),
              value: _jobRole,
              items: [
                'Developer',
                'Data Analyst',
                'Project Manager',
                'UI/UX Designer',
                'Scrum Master',
              ].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: mediumText(textGrey),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _jobRole = value!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
              ),
              hint: Text(
                'Select Gender',
                style: mediumText(textGrey),
              ),
              value: _gender,
              items: [
                'Male',
                'Female',
              ].map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: mediumText(textGrey),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _gender = value!;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      'Cancel',
                      style: mediumText(primaryBlack),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryWhite,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      'Apply filter',
                      style: medium(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(32))),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

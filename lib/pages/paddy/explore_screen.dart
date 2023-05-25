import 'package:career_paddy/components/autocomplete/search.dart';
import 'package:career_paddy/pages/paddy/filter.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late UserProvider provider;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    provider = context.read<UserProvider>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // provider.clearQuery(isMounted: false);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () async {
                          var query = await showModalBottomSheet(
                            context: context,
                            builder: (_) => Filter(),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                            ),
                          );
                          if (query != null) {
                            context.read<UserProvider>().setQuery(query);
                          }
                        },
                        icon: Icon(Icons.filter_list_sharp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //   TabBar(
                  //     indicatorColor: primaryBlue,
                  //     controller: _tabController,
                  //     unselectedLabelColor: textGrey,
                  //     labelColor: primaryBlue,
                  //     indicatorWeight: 2,
                  //     labelStyle: smallBold(primaryBlue),
                  //     indicator: const UnderlineTabIndicator(
                  //       borderSide: BorderSide(
                  //         width: 2,
                  //         color: primaryBlue,
                  //       ),
                  //     ),
                  //     tabs: [
                  //       Tab(
                  //         text: 'Career mentorship',
                  //       ),
                  //       Tab(
                  //         text: 'Mock Interview',
                  //       ),
                  //     ],
                  //   ),
                  //   SizedBox(
                  //     height: 20,
                  //   ),
                  //   Expanded(
                  //     child: TabBarView(
                  //       controller: _tabController,
                  //       children: [

                  //         MockInterviewers(),
                  //       ],
                  //     ),
                  //   )
                  CareerMentors(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

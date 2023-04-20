import 'package:career_paddy/components/jobs/jobs.dart';
import 'package:career_paddy/components/posts/posts.dart';
import 'package:flutter/material.dart';

import '../../components/autocomplete/search.dart';
import '../../components/users/career_mentor.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin{

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
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Community",
                style: largeText(primaryBlack),
              ),
              SizedBox(
                height: 20,
              ),
              AutocompleteSearch(),
              SizedBox(height: 20,),
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
                    text: 'Job Board',
                  ),
                  Tab(
                    text: 'Posts',
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
                    JobsPage(),
                    ArticleListPage(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:career_paddy/components/posts/posts.dart';
import 'package:career_paddy/pages/community/jobs.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/autocomplete/community.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    var prov = context.read<BottomNavProvider>();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
      () => prov.setTab(_tabController.index == 0 ? 'jobs' : 'posts'),
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;

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
              AutocompleteCommunitySearch(),
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
                    Jobs(
                      user: user,
                    ),
                    ArticleListPage(
                      user: user,
                    ),
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

import 'package:career_paddy/pages/sessions/meetings.dart';
import 'package:career_paddy/pages/sessions/notifications.dart';
import 'package:career_paddy/providers/bottom_nav.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';

class MySessions extends StatefulWidget {
  const MySessions({super.key});

  @override
  State<MySessions> createState() => _MySessionsState();
}

class _MySessionsState extends State<MySessions>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    var prov = context.read<BottomNavProvider>();
    var index = prov.isSeeAll ? 0 : 1;
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: index,
    );
    prov.close();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Sessions',
              style: largeText(darkBlue),
            ),
            SizedBox(
              height: 10,
            ),
            TabBar(
              controller: tabController,
              labelColor: primaryBlue,
              labelStyle: mediumBold(primaryBlue),
              unselectedLabelColor: textGrey,
              tabs: [
                Tab(
                  child: Text(
                    'Requests',
                    style: medium(),
                  ),
                ),
                Tab(
                  child: Text(
                    'Meetings',
                    style: medium(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SessionNotification(),
                  Meetings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

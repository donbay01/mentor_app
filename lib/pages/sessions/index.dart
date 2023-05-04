import 'package:career_paddy/pages/sessions/meetings.dart';
import 'package:career_paddy/pages/sessions/notifications.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/date.dart';
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
    tabController = TabController(length: 2, vsync: this);
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
              tabs: [
                Tab(
                  text: 'Requests',
                ),
                Tab(
                  text: 'Meetings',
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

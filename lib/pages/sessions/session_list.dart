import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/sessions/session_ui.dart';
import 'package:career_paddy/pages/sessions/sessions_page_ui.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final DateTime date;

  const SessionList({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AvailabilityService.getSessions(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        var data = snapshot.data;

        if (data != null && data.size > 0) {
          var sess = data.docs
              .map((e) => SessionModel.fromJson(e.id, e.data()))
              .toList();
          return Column(
            children: List.generate(
              data.size,
              (index) {
                var s = sess[index];

                return SessionPageUI(
                  session: s,
                );
                // return SessionUI(
                //   session: s,
                // );
              },
            ),
          );
        }

        return Text('No sessions for this date',style: medium(),);
      },
    );
  }
}

import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/sessions/session_ui.dart';
import 'package:career_paddy/services/availability.dart';
import 'package:flutter/material.dart';

class SessionList extends StatelessWidget {
  final DateTime date;

  const SessionList({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AvailabilityService.getSessions(date),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader();
        }

        if (snapshot.hasError) {
          return SizedBox.shrink();
        }

        if (snapshot.hasData && snapshot.data!.size == 0) {
          return Text('No sessions for this date');
        }

        var data = snapshot.data!;

        var sess = data.docs
            .map((e) => SessionModel.fromJson(e.id, e.data()))
            .toList();
        return Column(
          children: List.generate(
            data.size,
            (index) {
              var s = sess[index];
              return SessionUI(
                session: s,
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:career_paddy/pages/profile/paddy_profile.dart';
import 'package:flutter/material.dart';

class PaddyUpgrade extends StatelessWidget {
  const PaddyUpgrade({super.key});

  close(BuildContext context) => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Paddy Account'),
      content: Text(
        'Begin tutoring or having career sessions with your buddies to take them to the next level of their career',
      ),
      actions: [
        TextButton(
          onPressed: () => close(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            close(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PaddyProfile(),
              ),
            );
          },
          child: Text('Switch'),
        ),
      ],
    );
  }
}

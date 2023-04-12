import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';

class UsersInterests extends StatelessWidget {
  final UserModel user;

  const UsersInterests({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < user.interests!.length; i++) ...[
          Text(
            '${user.interests![i].name}${i == user.interests!.length - 1 ? '' : ','} ',
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ]
      ],
    );
  }
}

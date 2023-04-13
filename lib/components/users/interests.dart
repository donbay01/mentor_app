import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';

class UsersInterests extends StatelessWidget {
  final UserModel user;
  final TextStyle? style;

  const UsersInterests({
    super.key,
    required this.user,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          user.interests!.length,
          (index) {
            var interest = user.interests![index];

            return Text(
              '${interest.name}${index == user.interests!.length - 1 ? '' : ','} ',
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: style,
            );
          },
        ),
      ),
    );
  }
}

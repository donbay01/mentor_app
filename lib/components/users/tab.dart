import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class UserTab extends StatelessWidget {
  final UserModel user;

  const UserTab({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: Color(0xfff2f3f6),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Container(
              width: 309.17,
              height: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 99.67,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                    child: Center(
                      child: Text('About', style: small()),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(43.83, 6, 0, 6),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 73.67, 0),
                          child: Text(
                            'Reviews',
                            style: small(),
                          ),
                        ),
                        Text(
                          'Articles',
                          style: small(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            // imsenioruxstrategistatapplewit (80:777)
            constraints: BoxConstraints(
              maxWidth: 319,
            ),
            child: Text(
              user.bio ?? user.description ?? 'No bio has been setup',
              style: small(),
            ),
          ),
        ],
      ),
    );
  }
}

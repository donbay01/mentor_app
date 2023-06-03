import 'package:career_paddy/components/loader/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../providers/user.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../drawer/profile_icon.dart';
import 'book_sheet.dart';
import 'interests.dart';

class QueryList extends StatelessWidget {
  final Query<Map<String, dynamic>> query;
  final UserModel user;

  const QueryList({
    super.key,
    required this.query,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: query.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.hasData) {
          var ds = snapshot.data!.docs;
          if (ds.isEmpty) {
            return Center(
              child: Text('No results found!'),
            );
          }

          var a = ds
              .map((e) => UserModel.fromJson(e.id, e.data() as dynamic))
              .toList();

          return ListUI(
            users: a,
            user: user,
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class ListUI extends StatelessWidget {
  final List<UserModel> users;
  final UserModel user;

  const ListUI({
    super.key,
    required this.users,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var account = users[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () => buildShowModalBottomSheet(
              context,
              account,
              user,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.transparent,
              child: Row(
                children: [
                  ProfileIcon(
                    image: account.photoURL,
                    radius: 50,
                    isExternal: true,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.first_name,
                          style: mediumBold(darkBlue),
                        ),
                        if (account.interests != null) ...[
                          SizedBox(
                            height: 3,
                          ),
                          UsersInterests(user: account),
                        ],
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Text(
                              account.rating.toString(),
                              style: small(),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: 15,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buildShowModalBottomSheet(
    BuildContext context,
    UserModel user,
    UserModel mentee,
  ) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      enableDrag: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(80),
          topRight: Radius.circular(80),
        ),
      ),
      context: context,
      builder: (_) => BookSheet(
        user: user,
        mentee: mentee,
      ),
    );

    context.read<UserProvider>().cancelShift();
  }
}

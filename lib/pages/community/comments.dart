import 'package:career_paddy/models/comment_model.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/community.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final String id;

  const Comments({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserProvider>().getUser;
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments',
          style: small(),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: size.height * 0.555,
          child: PaginateFirestore(
            isLive: true,
            shrinkWrap: true,
            onEmpty: Center(
              child: Text('No comments'),
            ),
            query: CommunityService.getComments(id),
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder: (context, snapshots, index) {
              var snap = snapshots[index];
              var comment = CommentModel.fromJson(
                snap.id,
                snap.data() as dynamic,
              );

              return ListTile(
                title: Text(comment.commenter),
                subtitle: Text(comment.comment),
                trailing: user.uid == comment.commenterUid
                    ? IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => CommunityService().delete(
                          id,
                          comment.commentId,
                        ),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

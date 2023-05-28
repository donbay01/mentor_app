import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/community.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../helper/date.dart';
import '../../pages/community/new_post.dart';
import '../../pages/community/post_details.dart';
import '../../theme/text_style.dart';

class ArticleListPage extends StatelessWidget {
  final UserModel user;

  const ArticleListPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended for you',
              style: mediumBold(darkBlue),
            ),
            SizedBox(
              height: 20,
            ),
            PaginateFirestore(
              shrinkWrap: true,
              isLive: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, snapshots, index) {
                var snap = snapshots[index];
                var article = Article.fromJson(
                  snap.id,
                  snap.data() as dynamic,
                );

                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.title,
                            style: mediumBold(darkBlue),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(
                              DateHelper.formatRelative(article.date.toDate()),
                              style: smallBold(greyText),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.author,
                            style: smallBold(greyText),
                          ),
                          Text(
                            article.description,
                            style: small(),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailsPage(
                                    article: article,
                                  ),
                                ),
                              );
                            },
                            child: Text('Read more'),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('${article.viewers}')
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.chat,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('${article.comments}')
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailsPage(
                              article: article,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: greyText,
                    )
                  ],
                );
              },
              query: CommunityService.getPosts(),
              itemBuilderType: PaginateBuilderType.listView,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewPost(),
                  ),
                );
              },
              child: Icon(Icons.chat),
              backgroundColor: primaryBlue,
            )
    );
  }
}

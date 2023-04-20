import 'package:career_paddy/models/article_model.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';

import '../../pages/community/post_details.dart';
import '../../theme/text_style.dart';

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  List<Article> articles = [
    Article(
        title: "Business Etiquette",
        description:
            "Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. ",
        content:
            "Lorem ipsum dolor sit amet consectetur. Tristique magna feugiat vulputate urna. Commodo ullamcorper commodo in et etiam. Nisl malesuada laoreet praesent pellentesque nibh eget sit quam est. Nunc ipsum fringilla sodales tellus scelerisque faucibus amet dolor. Eget at dictumst volutpat risus id ipsum volutpat. Elementum purus sed odio erat sit. Turpis elementum nisi ac semper sem adipiscing egestas facilisis. Vitae cum suscipit posuere scelerisque. Molestie sagittis mollis amet vel eget magna quis tortor. Massa etiam turpis morbi viverra nunc in aliquam. Aliquam urna lectus ut lectus sodales. Pellentesque tristique semper consectetur porta. Lobortis justo pretium ornare odio. Non vel id maecenas vitae neque nisl porta elit egestas. Nisl dignissim nec tempus facilisi augue tellus. Dui fringilla urna adipiscing dictum ut laoreet nibh aenean. Vestibulum porttitor nunc egestas a diam ut nullam nunc. Scelerisque amet lobortis sit sed sapien leo. Et nibh tortor consequat purus in quis aenean.",
        author: 'Isaac John',
        comments: '200',
        viewers: "300"),
    Article(
      title: "Personal Branding",
      description:
          "Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. ",
      author: 'Ebuka Ekwenem',
      comments: '200',
      viewers: "300",
      content:
          "Lorem ipsum dolor sit amet consectetur. Tristique magna feugiat vulputate urna. Commodo ullamcorper commodo in et etiam. Nisl malesuada laoreet praesent pellentesque nibh eget sit quam est. Nunc ipsum fringilla sodales tellus scelerisque faucibus amet dolor. Eget at dictumst volutpat risus id ipsum volutpat. Elementum purus sed odio erat sit. Turpis elementum nisi ac semper sem adipiscing egestas facilisis. Vitae cum suscipit posuere scelerisque. Molestie sagittis mollis amet vel eget magna quis tortor. Massa etiam turpis morbi viverra nunc in aliquam. Aliquam urna lectus ut lectus sodales. Pellentesque tristique semper consectetur porta. Lobortis justo pretium ornare odio. Non vel id maecenas vitae neque nisl porta elit egestas. Nisl dignissim nec tempus facilisi augue tellus. Dui fringilla urna adipiscing dictum ut laoreet nibh aenean. Vestibulum porttitor nunc egestas a diam ut nullam nunc. Scelerisque amet lobortis sit sed sapien leo. Et nibh tortor consequat purus in quis aenean.",
    ),
    Article(
      title: "Career Building",
      description:
          "Lorem ipsum dolor sit amet consectetur. Tristique nunc arcu et elementum ut facilisis. ",
      author: 'Kokoma Brown',
      comments: '200',
      viewers: '300',
      content:
          "Lorem ipsum dolor sit amet consectetur. Tristique magna feugiat vulputate urna. Commodo ullamcorper commodo in et etiam. Nisl malesuada laoreet praesent pellentesque nibh eget sit quam est. Nunc ipsum fringilla sodales tellus scelerisque faucibus amet dolor. Eget at dictumst volutpat risus id ipsum volutpat. Elementum purus sed odio erat sit. Turpis elementum nisi ac semper sem adipiscing egestas facilisis. Vitae cum suscipit posuere scelerisque. Molestie sagittis mollis amet vel eget magna quis tortor. Massa etiam turpis morbi viverra nunc in aliquam. Aliquam urna lectus ut lectus sodales. Pellentesque tristique semper consectetur porta. Lobortis justo pretium ornare odio. Non vel id maecenas vitae neque nisl porta elit egestas. Nisl dignissim nec tempus facilisi augue tellus. Dui fringilla urna adipiscing dictum ut laoreet nibh aenean. Vestibulum porttitor nunc egestas a diam ut nullam nunc. Scelerisque amet lobortis sit sed sapien leo. Et nibh tortor consequat purus in quis aenean.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended for you',
            style: mediumBold(darkBlue),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        articles[index].title,
                        style: mediumBold(darkBlue),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articles[index].author,
                            style: smallBold(greyText),
                          ),
                          Text(
                            articles[index].description,
                            style: small(),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleDetailsPage(
                                        article: articles[index]),
                                  ),
                                );
                              },
                              child: Text('Read more')),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(articles[index].viewers)
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
                                  Text(articles[index].comments)
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
                            builder: (context) =>
                                ArticleDetailsPage(article: articles[index]),
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
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
        backgroundColor: primaryBlue,
      ),
    );
  }
}

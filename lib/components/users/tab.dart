import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // frame14hQv (80:768)
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // frame8f6r (80:769)
            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
            padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            width: double.infinity,
            height: 38,
            decoration: BoxDecoration(
              color: Color(0xfff2f3f6),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Container(
              // frame7AJW (80:770)
              width: 309.17,
              height: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // frame4He2 (80:771)
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
                    // autogroupf2uqNQa (YCGVEi9jV6xxDMT6izf2uQ)
                    padding: EdgeInsets.fromLTRB(43.83, 6, 0, 6),
                    height: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // reviewsJZ8 (80:774)
                          margin: EdgeInsets.fromLTRB(0, 0, 73.67, 0),
                          child: Text(
                            'Reviews',
                            style: small(),
                          ),
                        ),
                        Text(
                          // articlesdLW (80:776)
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
              'I’m  senior UX strategist at Apple with 12+ years of experience in the design industry. I help young professional navigate their career path with my level of expertise',
              style: small(),
            ),
          ),
        ],
      ),
    );
  }
}

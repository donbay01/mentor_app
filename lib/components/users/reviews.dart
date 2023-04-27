import 'package:career_paddy/models/review_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/session.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:star_rating/star_rating.dart';

class Reviews extends StatelessWidget {
  final UserModel user;
  final String meetingType;

  const Reviews({
    super.key,
    required this.user,
    required this.meetingType,
  });

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      isLive: true,
      shrinkWrap: true,
      onEmpty: Center(
        child: Text('No reviews'),
      ),
      separator: SizedBox(
        height: 10,
      ),
      itemBuilder: (context, snapshot, index) {
        var snap = snapshot[index];
        var review = ReviewModel.fromJson(
          snap.data() as dynamic,
        );

        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${review.mentee} gave a review of '),
                StarRating(
                  length: 5,
                  rating: review.stars,
                ),
              ],
            ),
          ],
        );
      },
      query: SessionService.getReviews(user.uid, meetingType),
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}

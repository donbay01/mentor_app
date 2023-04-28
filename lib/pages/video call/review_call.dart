import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:star_rating/star_rating.dart';

class ReviewCall extends StatefulWidget {
  final SessionModel session;

  const ReviewCall({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<ReviewCall> createState() => _ReviewCallState();
}

class _ReviewCallState extends State<ReviewCall> {
  final int starLength = 5;
  double _rating = 0;

  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  back() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Rate your session with your paddy',
                  style: medium(),
                ),
                SizedBox(
                  height: 20,
                ),
                StarRating(
                  mainAxisAlignment: MainAxisAlignment.center,
                  length: starLength,
                  rating: _rating,
                  between: 5,
                  starSize: 30,
                  onRaitingTap: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Message (Optional)',
                  style: smallText(textGrey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: reviewController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Leave a review message',
                    hintStyle: smallText(greyText),
                    suffixIcon: reviewController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              reviewController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: primaryBlue,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: back,
                      child: Text(
                        'Not now',
                        style: medium(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await ProgressService.show(context);
                        await SessionService.review(
                          widget.session.sessionId,
                          widget.session.mentorUid,
                          _rating,
                          widget.session.meetingType,
                          reviewController.text,
                        );
                        await ProgressService.hide();
                        back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Submit',
                          style: medium(),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

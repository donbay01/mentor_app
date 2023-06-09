import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/history/interviews.dart';
import 'package:career_paddy/pages/history/sessions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/text_style.dart';

class MenteePoints extends StatelessWidget {
  final UserModel user;

  const MenteePoints({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // GestureDetector(
          //   onTap: () => Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (ctx) => SessionsHistory(),
          //     ),
          //   ),
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * 0.1,
          //     width: MediaQuery.of(context).size.width * 0.42,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('assets/greenBox.png'),
          //       ),
          //       color: Colors.transparent,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(5.0),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 FontAwesomeIcons.coins,
          //                 color: Colors.green,
          //               ),
          //               Text(
          //                 ' Career Sessions',
          //                 style: smallBold(Colors.green),
          //               )
          //             ],
          //           ),
          //           Text(
          //             ' ${user.sessions}',
          //             style: large(),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => InterviewHistory(),
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/blueBox.png'),
                  fit: BoxFit.cover
                ),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_alt,
                          color: Colors.blue,
                        ),
                        Text(
                          ' Total Sessions',
                          style: mediumBold(Colors.blue),
                        )
                      ],
                    ),
                    Text(
                      ' ${user.sessions}',
                      style: large(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

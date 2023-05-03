import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/user_model.dart';
import '../../theme/text_style.dart';
import 'manage_points.dart';

class MentorPoints extends StatelessWidget {
  final UserModel user;

  const MentorPoints({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ManagePoints()));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/greenBox.png'),
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.coins,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Paddy Points',
                        style: smallBold(Colors.green),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Text(
                    ' ${user.paddy_points}',
                    style: large(),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.42,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blueBox.png'),
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Total Sessions',
                      style: smallBold(Colors.blue),
                      overflow: TextOverflow.ellipsis,
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
      ],
    );
  }
}

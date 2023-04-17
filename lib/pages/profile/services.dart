import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class UserServices extends StatelessWidget {
  final UserModel user;

  const UserServices({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: mediumBold(darkBlue),
        ),
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              user.interests?.length ?? 0,
              (index) {
                var interest = user.interests![index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: greyColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          interest.name,
                          style: smallText(textGrey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

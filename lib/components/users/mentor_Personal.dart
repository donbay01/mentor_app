import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/interest_model.dart';
import '../../providers/user.dart';
import '../../services/auth.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorPersonal extends StatelessWidget {
  const MentorPersonal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _gender;
    var service = AuthService();
    var user = service.getFirebaseUser()!;
    var live = context.watch<UserProvider>().getUser;


    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Name', style: small()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.displayName!,
                  style: mediumBold(darkBlue),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text('Email'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.email!,
                  style: mediumBold(darkBlue),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text('Phone Number'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  live.phoneNumber!,
                  style: mediumBold(darkBlue),
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        width: 1,
                        color: textGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1, color: primaryBlue),
                    ),
                  ),
                  hint: Text('Select Gender'),
                  value: _gender,
                  items: [
                    'Male',
                    'Female',
                  ].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) => _gender = value!,
                ),
                SizedBox(
                  height: 20,
                ),
              ],

        ),
      ),
    );
  }
}

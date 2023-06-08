import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user.dart';
import '../../services/auth.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorPersonal extends StatefulWidget {
  final UserModel user;
  final GlobalKey<FormState> formKey;

  const MentorPersonal({
    Key? key,
    required this.user,
    required this.formKey,
  }) : super(key: key);

  @override
  State<MentorPersonal> createState() => _MentorPersonalState();
}

class _MentorPersonalState extends State<MentorPersonal> {
  var bio = TextEditingController();
  String? _gender;
  var service = AuthService();
  bool _c = false, _m = false;

  @override
  void initState() {
    var a = context.read<UserProvider>();
    _gender = a.getGender ?? widget.user.gender;
    bio.text = a.bio ?? widget.user.bio ?? '';
    _m = a.isMockInterviewer ?? a.getUser.isMockInterviewer;
    _c = a.isCareerMentor ?? a.getUser.isCareerMentor;
    super.initState();
  }

  @override
  void dispose() {
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;
    var provider = context.watch<UserProvider>();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
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
              widget.user.phoneNumber!,
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
                    width: 0.5,
                    color: textGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: textGrey,
                  ),
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
                  child: Text(
                    status,
                    style: mediumText(textGrey),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _gender = value!;
                provider.holdGender(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Bio",
              style: mediumText(darkBlue),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == '' || value == null) {
                  return 'You need to complete your bio';
                }
              },
              controller: bio,
              onChanged: (value) => provider.holdBio(value),
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Your bio',
                hintStyle: smallText(greyText),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: greyText,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(width: 1, color: primaryBlue),
                ),
              ),
            ),
            if (widget.user.role == MENTOR) ...[
              SizedBox(
                height: 20,
              ),
              Text(
                'I can help with',
                style: mediumBold(textGrey),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Career roadmap and advice',
                    style: smallText(textGrey),
                  ),
                  Checkbox(
                    value: _c,
                    onChanged: (val) {
                      _c = !_c;
                      provider.holdCareerMentor(val!);
                      // service.updateField({
                      //   'isCareerMentor': _c,
                      // });

                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mock Interviews',
                    style: smallText(textGrey),
                  ),
                  Checkbox(
                    value: _m,
                    onChanged: (val) {
                      _m = !_m;
                      provider.holdMockInterview(val!);
                      // service.updateField({
                      //   'isMockInterviewer': _m,
                      // });

                      setState(() {});
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

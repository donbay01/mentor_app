import 'package:awesome_select/awesome_select.dart';
import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/components/resume/index.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/pages/profile/avatar.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/picker.dart';
import 'package:career_paddy/services/upload.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io' show File;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _gender;
  String? _resume;
  String? _employmentStatus;
  List<InterestModel> _interests = [], sel = [];

  final _formKey = GlobalKey<FormState>();
  var service = AuthService();

  UploadTask? task;

  @override
  void didChangeDependencies() {
    _interests = context.watch<InterestProvider>().getInterests;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;
    var live = context.watch<UserProvider>().getUser;

    _gender = live.gender;
    _employmentStatus = live.employment;
    sel = live.interests ?? [];

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryBlack,
            size: 25,
          ),
        ),
        title: Text(
          'Complete Your Profile',
          style: TextStyle(color: primaryBlack, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatar(
                      user: user,
                    ),
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
                              borderSide:
                                  BorderSide(width: 1, color: textGrey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 1, color: primaryBlue))),
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
                    SizedBox(height: 16.0),
                    Text(
                      'Employment Status',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: textGrey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(width: 1, color: primaryBlue))),
                      hint: Text('Select Status'),
                      value: _employmentStatus,
                      items:
                          ['Employed', 'Unemployed', 'Student'].map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) => _employmentStatus = value,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Interest",
                      style: medium(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SmartSelect<InterestModel?>.multiple(
                      title: 'Interest',
                      placeholder: 'Choose your interests',
                      selectedValue: sel,
                      onChange: (selected) {},
                      modalType: S2ModalType.bottomSheet,
                      modalHeader: false,
                      choiceLayout: S2ChoiceLayout.wrap,
                      choiceDirection: Axis.vertical,
                      choiceItems:
                          S2Choice.listFrom<InterestModel, InterestModel>(
                        source: _interests,
                        value: (index, item) => item,
                        title: (index, item) => item.name,
                        subtitle: (index, item) => item.name,
                        meta: (index, item) => item,
                      ),
                      choiceBuilder: (context, state, choice) {
                        return GestureDetector(
                          onTap: () {
                            var val = choice.value!;
                            if (sel.contains(val)) {
                              sel.remove(val);
                            } else {
                              sel.add(val);
                            }

                            choice.select?.call(!choice.selected);
                          },
                          child: Chip(
                            backgroundColor:
                                choice.selected ? primaryBlue : null,
                            label: Text(
                              choice.title!,
                              style: TextStyle(
                                color: choice.selected ? Colors.white : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Resume",
                      style: medium(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Resume(
                      task: task,
                      user: live,
                      onFileChanged: (file) async {
                        var path = 'users/${user.uid}';
                        task = UploadService.upload(path, file);

                        setState(() {});
                        await task;
                        _resume = await UploadService.getUrl(task!);
                        SnackBarHelper.displayToastMessage(
                          context,
                          'Resume uploaded',
                          primaryBlue,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: mediumText(primaryBlack),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await service.updateProfile(
                              gender: _gender,
                              employment: _employmentStatus,
                              resume: _resume,
                              interests: sel.map((e) => e.name).toList(),
                            );
                            SnackBarHelper.displayToastMessage(
                              context,
                              'Updated profile',
                              primaryBlue,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Save Changes',
                              style: medium(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

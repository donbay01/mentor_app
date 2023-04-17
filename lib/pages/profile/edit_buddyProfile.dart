import 'package:awesome_select/awesome_select.dart';
import 'package:career_paddy/pages/profile/avatar.dart';
import 'package:career_paddy/pages/profile/save_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/interest_model.dart';
import '../../models/user_model.dart';
import '../../providers/interests.dart';
import '../../providers/user.dart';
import '../../services/auth.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class EditBuddyProfile extends StatefulWidget {
  final UserModel user;

  const EditBuddyProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditBuddyProfile> createState() => _EditBuddyProfileState();
}

class _EditBuddyProfileState extends State<EditBuddyProfile>
    with TickerProviderStateMixin{
  var service = AuthService();
  var bio = TextEditingController();
  String? _gender;
  String? _employmentStatus;
  List<InterestModel> _interests = [], sel = [];
  TextEditingController _resume = TextEditingController();

  @override
  void initState() {
    _gender = widget.user.gender;
    _employmentStatus = widget.user.employment;
    _resume.text = widget.user.resume ?? '';
    bio.text = widget.user.bio ?? '';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _interests = context.read<InterestProvider>().getInterests;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var live = context.watch<UserProvider>().getUser;
    var user = service.getFirebaseUser()!;
    var provider = context.watch<UserProvider>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileAvatar(
                        user: user,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Kindly provide us with the following information for verification',
                        style: medium(),
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
                        widget.user.phoneNumber!,
                        style: mediumBold(darkBlue),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "About me",
                        style: mediumText(darkBlue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bio,
                        onChanged: (value) => provider.holdBio(bio.text),
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
                        onChanged: (value) {
                          _gender = value!;
                          provider.holdGender(value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Employment Status',
                        style: mediumText(darkBlue),
                      ),
                      SizedBox(height: 10.0),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5, color: textGrey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: textGrey,
                            ),
                          ),
                        ),
                        hint: Text('Select Status', style: mediumText(textGrey)),
                        value: _employmentStatus,
                        items: ['Employed', 'Unemployed', 'Student'].map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(
                              status,
                              style: mediumText(textGrey),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _employmentStatus = value;
                          provider.holdEmployment(value!);
                        },
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
                        title: 'View all',
                        placeholder: sel.isEmpty
                            ? 'Choose your interests'
                            : '${sel.length} interests picked',
                        selectedValue: sel,
                        onChange: (selected) {},
                        modalType: S2ModalType.bottomSheet,
                        modalHeader: false,
                        choiceLayout: S2ChoiceLayout.wrap,
                        choiceDirection: Axis.vertical,
                        choiceItems: S2Choice.listFrom<InterestModel, InterestModel>(
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
                              } else if (!sel.contains(val) && sel.length <= 3) {
                                sel.add(val);
                                choice.select?.call(!choice.selected);
                              }

                              provider.holdInterests(sel);
                            },
                            child: Chip(
                              backgroundColor: choice.selected ? primaryBlue : null,
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Resume",
                        style: mediumText(darkBlue),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _resume,
                        onChanged: (value) => provider.holdResume(_resume.text),
                        decoration: InputDecoration(
                          hintText: 'URL to access resume',
                          hintStyle: smallText(textGrey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: textGrey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(width: 1, color: primaryBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SaveButton(),
      ),
    );
  }
}

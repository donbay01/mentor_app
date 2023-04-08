import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _gender;
  String? _employmentStatus;
  List<String> _interests = [];
  TextEditingController interestController = TextEditingController();
  TextEditingController resumeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Complete Your Profile',
                          style: largeText(darkBlue),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/adaptLogo.png'),
                      radius: 30,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Name', style: small()),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Kokoma',
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
                      'Kokoma@gmail.com',
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
                      '0906 888 2782',
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
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
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
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    // Row(
                    //   children: [
                    //     // Radio(
                    //     //   value: 'male',
                    //     //   groupValue: _gender,
                    //     //   onChanged: (value) {
                    //     //     setState(() {
                    //     //       _gender = value;
                    //     //     });
                    //     //   },
                    //     // ),
                    //     // Text('Male'),
                    //
                    //   ],
                    // ),
                    SizedBox(height: 16.0),
                    Text(
                      'Employment Status',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      hint: Text('Select Status'),
                      value: _employmentStatus,
                      items:
                          ['Employed', 'Unemployed', 'Student'].map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _employmentStatus = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    Text("Interest",style:medium(),),
                    SizedBox(height: 10,),
                    TextFormField(
                      style: small(),
                      controller: interestController,
                      autofillHints: const [AutofillHints.email],
                      onEditingComplete: () => [
                        // TextInput.finishAutofillContext(),
                        FocusScope.of(context).unfocus(),
                      ],
                      decoration: InputDecoration(
                        labelText: 'interest',
                        hintText: 'eg Artificial Intelligence',
                        hintStyle: smallText(textGrey),
                        suffixIcon: interestController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  interestController.clear();
                                },
                              ),
                        filled: true,
                        fillColor: primaryWhite,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: darkBlue,
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    Text("Resume",style:medium(),),
                    SizedBox(height: 10,),
                    TextFormField(
                      style: small(),
                      controller: resumeController,
                      autofillHints: const [AutofillHints.email],
                      onEditingComplete: () => [
                        // TextInput.finishAutofillContext(),
                        FocusScope.of(context).unfocus(),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Resume',
                        hintText: 'An accessible link to your resume',
                        hintStyle: smallText(textGrey),
                        suffixIcon: resumeController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  resumeController.clear();
                                },
                              ),
                        filled: true,
                        fillColor: primaryWhite,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: darkBlue,
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
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20,),
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
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Save Changes', style: medium(),),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(32))),
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

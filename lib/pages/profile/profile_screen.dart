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
                        child: Text('Complete Your Profile',style: largeText(darkBlue),)),
                    SizedBox(height: 20,),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/adaptLogo.png'),
                      radius: 30,
                    ),
                    SizedBox(height: 20,),
                    Text('Name',style: small()),
                    SizedBox(height: 10,),
                    Text('Kokoma',style: mediumBold(darkBlue),),
                    Divider(),
                    SizedBox(height: 20,),
                    Text('Email'),
                    SizedBox(height: 10,),
                    Text('Kokoma@gmail.com',style: mediumBold(darkBlue),),
                    Divider(),
                    SizedBox(height: 20,),
                    Text('Phone Number'),
                    SizedBox(height: 10,),
                    Text('0906 888 2782',style: mediumBold(darkBlue),),
                    Divider(),
                    SizedBox(height: 20,),
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Radio(
                          value: 'male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        Text('Male'),
                        Radio(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
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
                      value: _employmentStatus,
                      items: ['Employed', 'Unemployed', 'Student'].map((status) {
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
                    SizedBox(height: 16.0),
                    Text(
                      'Interests',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CheckboxListTile(
                      title: Text('Mobile Development'),
                      value: _interests.contains('Mobile Development'),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            _interests.add('Mobile Development');
                          } else {
                            _interests.remove('Mobile Development');
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Web Development'),
                      value: _interests.contains('Web Development'),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            _interests.add('Web Development');
                          } else {
                            _interests.remove('Web Development');
                          }
                        });
                      },
                    ),
                    SizedBox(height: 16.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                            onPressed: () {

                            },
                            child: Text('Save Changes'),
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

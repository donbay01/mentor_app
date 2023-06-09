import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String? _gender;
  InterestModel? _industry;
  InterestModel? _jobRole;
  UserProvider? provider;

  var db = FirebaseFirestore.instance;

  Query<Map<String, dynamic>> getQuery() {
    var q = db.collection('users').orderBy('uid');

    if (_gender != null) {
      q = q.where('gender', isEqualTo: _gender);
    }

    if (_industry != null && _jobRole == null) {
      q = q.where('interests', arrayContains: _industry!.name);
    }

    if (_jobRole != null && _industry == null) {
      q = q.where('interests', arrayContains: _jobRole!.name);
    }

    if (_jobRole != null && _industry != null) {
      q = q.where(
        'interests',
        whereIn: [
          _industry!.name,
          _jobRole!.name,
        ],
      );
    }

    return q;
  }

  back() {
    Navigator.of(context).pop(getQuery());
  }

  @override
  void initState() {
    provider = context.read<UserProvider>();
    _industry = provider!.interest;
    _jobRole = provider!.job;
    _gender = provider!.gq;
    print(_gender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = context.read<InterestProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filter',
                  style: mediumBold(primaryBlack),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<InterestModel>(
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
                hint: Text('Industry', style: mediumText(textGrey)),
                value: _industry,
                items: prov.industries.map((status) {
                  return DropdownMenuItem<InterestModel>(
                    value: status,
                    child: Text(
                      status.name,
                      style: mediumText(textGrey),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _industry = value;
                  provider?.setInterest(value!);
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<InterestModel>(
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
                hint: Text(
                  'Job Role',
                  style: mediumText(textGrey),
                ),
                value: _jobRole,
                items: prov.getInterests.map((status) {
                  return DropdownMenuItem<InterestModel>(
                    value: status,
                    child: Text(
                      status.name,
                      style: mediumText(textGrey),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  _jobRole = value!;
                  provider?.holdJob(value);
                },
              ),
              SizedBox(
                height: 20,
              ),
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
                hint: Text(
                  'Select Gender',
                  style: mediumText(textGrey),
                ),
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
                  _gender = value;
                  provider?.holdqg(value!);
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      provider?.clearQuery();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Text(
                        'Clear',
                        style: mediumText(primaryBlack),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryWhite,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: back,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Text(
                        'Apply filter',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

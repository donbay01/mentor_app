import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/user_experience.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class NewExperience extends StatefulWidget {
  final UserProvider provider;

  const NewExperience({
    super.key,
    required this.provider,
  });

  @override
  State<NewExperience> createState() => _NewExperienceState();
}

class _NewExperienceState extends State<NewExperience> {
  TextEditingController _jobRole = TextEditingController();
  TextEditingController _company = TextEditingController();
  TextEditingController _start = TextEditingController();
  TextEditingController _end = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  var key = GlobalKey<FormState>();
  DateTime today = DateTime.now();

  @override
  void dispose() {
    _jobRole.dispose();
    _company.dispose();
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  Future<DateTime?> _getDate() => showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(1960),
        lastDate: today.add(
          Duration(days: 365),
        ),
      );

  save() async {
    bool isValid = await key.currentState!.validate();

    if (!isValid) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Fill in all compulsory fields',
        primaryBlue,
      );
    }

    var experience = UserExperience(
      jobRole: _jobRole.text,
      company: _company.text,
      start: Timestamp.fromDate(_startDate!),
      end: Timestamp.fromDate(_endDate!),
    );
    // widget.provider.addExperience(experience);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(20),
        title: Text('New experience'),
        children: [
          Text(
            "Job Role",
            style: mediumText(darkBlue),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _jobRole,
            onChanged: (value) => widget.provider.holdField(_jobRole.text),
            decoration: InputDecoration(
              hintText: 'e.g Senior Product Designer',
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
            "Company name",
            style: mediumText(darkBlue),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (value) => widget.provider.holdCompany(_company.text),
            controller: _company,
            decoration: InputDecoration(
              hintText: 'Your current workplace',
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
          SizedBox(
            height: 20,
          ),
          Text('Start Date'),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _start,
            onTap: () async {
              _startDate = await _getDate();
              var format = DateHelper.formatDate(_startDate!);
              _start.text = format;
            },
            decoration: InputDecoration(
              hintText: 'Start Date',
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
          Text('End Date'),
          TextFormField(
            controller: _end,
            onTap: () async {
              _endDate = await _getDate();
              var format = DateHelper.formatDate(_endDate!);
              _end.text = format;
            },
            decoration: InputDecoration(
              hintText: 'End Date',
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
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: save,
                child: Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

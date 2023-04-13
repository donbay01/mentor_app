import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/interest_model.dart';
import '../../providers/user.dart';
import '../../services/auth.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorExperience extends StatelessWidget {
  const MentorExperience({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _employmentStatus;
    String? _startDate;
    String? _endDate;
    List<InterestModel> _interests = [], sel = [];
    TextEditingController _jobRole = TextEditingController();
    TextEditingController _company = TextEditingController();

    var service = AuthService();
    var user = service.getFirebaseUser()!;
    var live = context.watch<UserProvider>().getUser;

    _employmentStatus = live.employment;
    sel = live.interests ?? [];


    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 20,),
            //Add Start Date and End date
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('Start Date'),
            //         SizedBox(height: 10,),
            //         DropdownButtonFormField<String>(
            //           decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(width: 1, color: textGrey),
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20),
            //               borderSide: BorderSide(
            //                 width: 1,
            //                 color: primaryBlue,
            //               ),
            //             ),
            //           ),
            //           hint: Text('Month'),
            //           value: _startDate,
            //           items:
            //           ['January', 'February', 'March'].map((status) {
            //             return DropdownMenuItem<String>(
            //               value: status,
            //               child: Text(status),
            //             );
            //           }).toList(),
            //           onChanged: (value) => _startDate = value,
            //         ),
            //       ],
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text('End Date'),
            //         SizedBox(height: 10,),
            //         DropdownButtonFormField<String>(
            //           decoration: InputDecoration(
            //             enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(width: 1, color: textGrey),
            //               borderRadius: BorderRadius.circular(20),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20),
            //               borderSide: BorderSide(
            //                 width: 1,
            //                 color: primaryBlue,
            //               ),
            //             ),
            //           ),
            //           hint: Text('Month'),
            //           value: _endDate,
            //           items:
            //           ['January', 'February', 'March'].map((status) {
            //             return DropdownMenuItem<String>(
            //               value: status,
            //               child: Text(status),
            //             );
            //           }).toList(),
            //           onChanged: (value) => _endDate = value,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(height: 20.0),
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
                  borderSide: BorderSide(
                    width: 1,
                    color: primaryBlue,
                  ),
                ),
              ),
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
              "Services",
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
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

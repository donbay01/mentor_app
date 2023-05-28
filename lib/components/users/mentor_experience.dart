import 'package:awesome_select/awesome_select.dart';
import 'package:career_paddy/components/users/experience_list.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/providers/interests.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/interest_model.dart';
import '../../providers/user.dart';
import '../../services/auth.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class MentorExperience extends StatefulWidget {
  final UserModel user;
  final GlobalKey<FormState> formKey;

  const MentorExperience({
    Key? key,
    required this.user,
    required this.formKey,
  }) : super(key: key);

  @override
  State<MentorExperience> createState() => _MentorExperienceState();
}

class _MentorExperienceState extends State<MentorExperience> {
  String? _employmentStatus;
  List<InterestModel> _interests = [], sel = [];
  var service = AuthService();

  @override
  void initState() {
    context.read<InterestProvider>().load();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _interests = context.watch<InterestProvider>().getInterests;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserProvider>();

    var live = provider.getUser;

    _employmentStatus = provider.getEmployment ?? live.employment;
    sel = live.interests ?? [];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExperienceList(
              provider: provider,
            ),
            SizedBox(height: 20.0),
            Text(
              'Employment Status',
              style: mediumText(darkBlue),
            ),
            SizedBox(height: 10.0),
            DropdownButtonFormField<String>(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Pick a status';
                }
              },
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
              "Industry",
              style: medium(),
            ),
            SizedBox(
              height: 10,
            ),
            SmartSelect<InterestModel?>.multiple(
              // validation: (value) {
              //   if (value.isEmpty) {
              //     return 'You need to pick at least one interest';
              //   }

              //   return '';
              // },
              title: 'View all',
              placeholder: sel.isEmpty
                  ? 'Choose your Industry'
                  : '${sel.length} Industry picked',
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
                var isSelected = choice.selected ||
                    sel
                        .where((e) => e.name == choice.value!.name)
                        .toList()
                        .isNotEmpty;

                return GestureDetector(
                  onTap: () {
                    var val = choice.value!;
                    if (isSelected) {
                      var s = sel.where((e) => e.name != val.name).toList();
                      sel = s;
                      choice.select?.call(!isSelected);
                    } else if (!sel.contains(val) && sel.length <= 3) {
                      sel.add(val);
                      choice.select?.call(!choice.selected);
                    }

                    provider.holdInterests(sel);
                  },
                  child: Chip(
                    backgroundColor: isSelected ? primaryBlue : null,
                    label: Text(
                      choice.title!,
                      style: TextStyle(
                        color: isSelected ? Colors.white : null,
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

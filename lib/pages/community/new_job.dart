import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/job_model.dart';
import 'package:career_paddy/pages/community/job_details.dart';
import 'package:career_paddy/services/community.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/progress.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'package:listtextfield/listtextfield.dart';

class NewJob extends StatefulWidget {
  const NewJob({Key? key}) : super(key: key);

  @override
  State<NewJob> createState() => _NewJobState();
}

class _NewJobState extends State<NewJob> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController jobRoleController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController jobLevelController = TextEditingController();
  TextEditingController minPay = TextEditingController();
  TextEditingController maxPay = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController link = TextEditingController();

  final jobQualificationController = ListTextEditingController(',');
  final jobDescriptionController = ListTextEditingController(',');

  @override
  void dispose() {
    companyNameController.dispose();
    jobDescriptionController.dispose();
    jobLevelController.dispose();
    minPay.dispose();
    maxPay.dispose();
    link.dispose();
    // jobDescriptionController.dispose();
    // jobQualificationController.dispose();
    experienceController.dispose();
    introController.dispose();
    super.dispose();
  }

  save() async {
    try {
      var job = JobModel(
        role: jobRoleController.text,
        date: Timestamp.now(),
        intro: introController.text,
        minPay: int.parse(minPay.text),
        maxPay: int.parse(maxPay.text),
        experience: experienceController.text,
        descriptions: jobDescriptionController.items,
        qualifications: jobQualificationController.items,
        company: companyNameController.text,
        link: link.text,
      );

      await ProgressService.show(context);
      await CommunityService.addJob(job);
      await ProgressService.hide();
      Navigator.of(context).pop();
    } on FirebaseException catch (e) {
      await ProgressService.hide();
      SnackBarHelper.displayToastMessage(
        context,
        e.message!,
        primaryBlue,
      );
    }
  }

  preview() {
    var job = JobModel(
      role: jobRoleController.text,
      date: Timestamp.now(),
      intro: introController.text,
      minPay: int.parse(minPay.text),
      maxPay: int.parse(maxPay.text),
      experience: experienceController.text,
      descriptions: jobDescriptionController.items,
      qualifications: jobQualificationController.items,
      company: companyNameController.text,
      link: link.text,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => JobDetailsPage(
          job: job,
          isPreview: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryBlue,
              size: 20,
            ),
          ),
          title: Text(
            'Community',
            style: mediumText(primaryBlue),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Job Post',
                  style: large(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Company name',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: companyNameController,
                  decoration: InputDecoration(
                    hintText: 'Eg Alula Learning',
                    hintStyle: smallText(greyText),
                    suffixIcon: companyNameController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              companyNameController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Intro',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: introController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Intro',
                    hintStyle: smallText(greyText),
                    suffixIcon: introController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              introController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Job Role',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jobRoleController,
                  decoration: InputDecoration(
                    hintText: 'Eg Junior Product Designer',
                    hintStyle: smallText(greyText),
                    suffixIcon: jobRoleController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              jobRoleController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Job Level',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jobLevelController,
                  decoration: InputDecoration(
                    hintText: 'Eg Entry level',
                    hintStyle: smallText(greyText),
                    suffixIcon: jobLevelController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              jobLevelController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Min Pay Range',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: minPay,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'N150,000 - N700,000',
                    hintStyle: smallText(greyText),
                    suffixIcon: minPay.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              minPay.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Max Pay Range',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: maxPay,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '150000',
                    hintStyle: smallText(greyText),
                    suffixIcon: maxPay.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              maxPay.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Years of Experience',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: experienceController,
                  decoration: InputDecoration(
                    hintText: '3-4 years',
                    hintStyle: smallText(greyText),
                    suffixIcon: experienceController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              experienceController.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Separate description with a comma',
                  style: small(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Job Description',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTextField(
                  controller: jobDescriptionController,
                  itemBuilder: (_, value) {
                    return Chip(
                      label: Text(value),
                      onDeleted: () =>
                          jobDescriptionController.removeItem(value),
                    );
                  },
                  itemSpacing: 8,
                  itemLineSpacing: 4,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide()),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Separate Qualification with a comma',
                  style: small(),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Job Qualification',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTextField(
                  controller: jobQualificationController,
                  itemBuilder: (_, value) {
                    return Chip(
                      label: Text(value),
                      onDeleted: () =>
                          jobQualificationController.removeItem(value),
                    );
                  },
                  itemSpacing: 8,
                  itemLineSpacing: 4,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Apply Link',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: link,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'https://forms.google.com/abc',
                    hintStyle: smallText(greyText),
                    suffixIcon: link.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              link.clear();
                            },
                          ),
                    filled: true,
                    fillColor: primaryWhite,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: greyText,
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: preview,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Preview',
                    style: mediumBold(primaryBlack),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryWhite,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: save,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Post job',
                    style: mediumBold(primaryWhite),
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
          ),
        ),
      ),
    );
  }
}

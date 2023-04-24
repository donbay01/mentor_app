import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class NewJob extends StatelessWidget {
  const NewJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController companyNameController = TextEditingController();
    TextEditingController jobRoleController = TextEditingController();
    TextEditingController jobLevelController = TextEditingController();
    TextEditingController payRangeController = TextEditingController();
    TextEditingController jobDescriptionController = TextEditingController();
    TextEditingController jobQualificationController = TextEditingController();
    TextEditingController experienceController = TextEditingController();

    return Scaffold(
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
                'Pay Range',
                style: mediumBold(textGrey),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: payRangeController,
                decoration: InputDecoration(
                  hintText: 'N150,000 - N700,000',
                  hintStyle: smallText(greyText),
                  suffixIcon: payRangeController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            payRangeController.clear();
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
                height: 10,
              ),
              Text(
                'Job Description',
                style: mediumBold(textGrey),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: jobDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  hintStyle: smallText(greyText),
                  suffixIcon: jobDescriptionController.text.isEmpty
                      ? Container(
                          width: 0,
                        )
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            jobDescriptionController.clear();
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
                'Job Qualification',
                style: mediumBold(textGrey),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: jobQualificationController,
                decoration: InputDecoration(
                  hintText: 'Enter job qualification',
                  hintStyle: smallText(greyText),
                  suffixIcon: jobQualificationController.text.isEmpty
                      ? Container(
                    width: 0,
                  )
                      : IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      jobQualificationController.clear();
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
              SizedBox(height: 20,)
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
              onPressed: () {},
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
            SizedBox(width: 10,),
            ElevatedButton(
              onPressed: () {},
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
    );
  }
}

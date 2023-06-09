import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/job_model.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../components/list/bullet.dart';

class JobDetailsPage extends StatelessWidget {
  final JobModel job;
  final bool isPreview;

  const JobDetailsPage({
    super.key,
    required this.job,
    this.isPreview = false,
  });

  String formatNumber(int num) => NumberFormat("#,###").format(num);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: primaryBlue,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Community',
            style: mediumText(primaryBlue),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileIcon(
                          image: job.image,
                          isExternal: true,
                          radius: 40,
                        ),
                        SizedBox(width: 5),
                        Text(
                          job.role,
                          style: mediumBold(primaryBlack),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        DateHelper.formatRelative(job.date.toDate()),
                        style: smallBold(greyText),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  job.intro,
                  style: smallText(greyText),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.nairaSign,size: 15,color: greyText,),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${formatNumber(job.minPay)} ',
                          style: smallText(greyText),
                        ),
                        Text('- '),
                        Icon(FontAwesomeIcons.nairaSign,size: 15,color: greyText,),
                        Text(
                          ' ${formatNumber(job.maxPay)}',
                          style: smallText(greyText),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${job.experience} years',
                          style: smallText(greyText),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Job Descriptions', style: mediumBold(primaryBlack)),
                SizedBox(height: 8.0),
                BulletList(
                  items: job.descriptions,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Qualifications',
                  style: mediumBold(primaryBlack),
                ),
                SizedBox(height: 8.0),
                BulletList(
                  items: job.qualifications,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: !isPreview
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => launchUrlString(
                    job.link,
                    mode: LaunchMode.inAppWebView,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: primaryBlue,
                    ),
                    child: Center(
                      child: Text(
                        'Apply Now',
                        style: mediumBold(primaryWhite),
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

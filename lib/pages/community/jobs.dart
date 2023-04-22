import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/job_model.dart';
import 'package:career_paddy/services/community.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'job_details.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      itemBuilderType: PaginateBuilderType.listView,
      isLive: true,
      shrinkWrap: true,
      separator: const SizedBox(
        height: 10,
      ),
      query: CommunityService.getJobs(),
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];
        var job = JobModel.fromJson(snap.data() as dynamic);

        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JobDetailsPage(
                  job: job,
                ),
              ),
            );
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfileIcon(
                    image: job.image,
                    isExternal: true,
                    radius: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    job.role,
                    style: mediumBold(primaryBlack),
                  ),
                ],
              ),
              Text(
                DateHelper.formatRelative(job.date.toDate()),
                style: smallBold(greyText),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                      Icon(Icons.monetization_on_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$ ${job.minPay} - \$ ${job.maxPay}',
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
              Divider(color: primaryBlack)
            ],
          ),
        );
      },
    );
  }
}

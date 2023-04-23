import 'package:career_paddy/models/plan_model.dart';
import 'package:career_paddy/pages/payment/cancel.dart';
import 'package:career_paddy/pages/payment/tick.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:career_paddy/services/plans.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class PaymentPlans extends StatelessWidget {
  const PaymentPlans({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<PlansProvider>();
    String _subscriptionType = prov.name;

    return PaginateFirestore(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      isLive: true,
      separator: SizedBox(height: 20.0),
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];
        var plan = PlanModel.fromJson(
          snap.id,
          snap.data() as dynamic,
        );

        return Center(
          child: GestureDetector(
            onTap: () => prov.setPlan(plan),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: greyText, width: 1),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text(plan.name),
                    value: plan.name.toLowerCase(),
                    groupValue: _subscriptionType,
                    onChanged: (value) {
                      prov.changeName(value!);
                      prov.setPlan(plan);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        plan.sessions > 0 ? Tick() : Cancel(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Career sections',
                          style: small(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        plan.interviews > 0 ? Tick() : Cancel(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Mock interviews',
                          style: small(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        plan.isLearning ? Tick() : Cancel(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Learning resources',
                          style: small(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        Tick(),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Community (Job board & \nIndustry related articles)',
                          style: small(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      query: PlanService.getPlans(),
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}

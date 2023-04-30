import 'package:career_paddy/models/plan_model.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:flutter/material.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'package:career_paddy/pages/payment/tick.dart';
import 'package:career_paddy/pages/payment/cancel.dart';

class PaymentCard extends StatelessWidget {
  final PlansProvider prov;
  final PlanModel plan;

  const PaymentCard({
    super.key,
    required this.prov,
    required this.plan,
  });

  showColor(PlanModel? provPlan) {
    if (prov.plan == null) {
      return greyText;
    }

    if (prov.plan?.name.toLowerCase() == plan.name.toLowerCase()) {
      return primaryBlue;
    }

    return greyText;
  }

  @override
  Widget build(BuildContext context) {
    String _subscriptionType = prov.name;

    return GestureDetector(
      onTap: () {
        prov.changeName(plan.name.toLowerCase());
        prov.setPlan(plan);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: showColor(prov.plan),
            width: 1,
          ),
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
                    '${plan.sessions} Career sections',
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
                    '${plan.interviews} Mock interviews',
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
    );
  }
}

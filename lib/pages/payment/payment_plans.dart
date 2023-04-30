import 'package:career_paddy/models/plan_model.dart';
import 'package:career_paddy/pages/payment/payment_card.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:career_paddy/services/plans.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';

class PaymentPlans extends StatelessWidget {
  const PaymentPlans({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = context.watch<PlansProvider>();

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

        return PaymentCard(
          plan: plan,
          prov: prov,
        );
      },
      query: PlanService.getPlans(),
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}

import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/payment/payment_plans.dart';
import 'package:career_paddy/pages/payment/payment_webview.dart';
import 'package:career_paddy/providers/plans.dart';
import 'package:career_paddy/services/plans.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatelessWidget {
  final UserModel user;

  const SubscriptionPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var prov = context.watch<PlansProvider>();

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 15,
          ),
        ),
        title: Text(
          "Subscription",
          style: mediumText(primaryBlue),
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose your plan",
                style: large(),
              ),
              SizedBox(height: 10.0),
              Text(
                "Flexible pricing just for you.",
                style: small(),
              ),
              SizedBox(height: 20.0),
              PaymentPlans(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () async {
            try {
              var plan = prov.plan!;
              if (prov.name.toLowerCase() == 'free') {
                return SnackBarHelper.displayToastMessage(
                  context,
                  'Can not pay for a free plan',
                  primaryBlue,
                );
              }

              await ProgressService.show(context);
              var res = await PlanService.getLink(plan);
              await ProgressService.hide();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PaymentWebview(url: res),
                ),
              );
            } on FirebaseFunctionsException catch (e) {
              await ProgressService.hide();
              SnackBarHelper.displayToastMessage(
                context,
                e.message!,
                primaryBlue,
              );
            }
          },
          child: Container(
            height: size.height * 0.05,
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: primaryBlue,
            ),
            child: Center(
              child: Text(
                'Proceed to checkout',
                style: mediumBold(primaryWhite),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

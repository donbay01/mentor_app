import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class PaymentFailed extends StatelessWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.cancel,
            size: 60,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
                'Your transaction was not successful',
                style: mediumText(textGrey),
              )),
        ],
      ),
    );
  }
}

import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.gpp_good,
            size: 60,
            color: Colors.green,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Your transaction was successful',
              style: mediumText(textGrey),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: TextButton(
              child: Text('Return to home'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

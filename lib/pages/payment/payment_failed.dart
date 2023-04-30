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
            size: 100,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'Payment Failed',
              style: largeText(primaryBlack),
            ),
          ),
          SizedBox(height: 10,),
          Text('Sorry, your transaction did not go through.',style: smallText(textGrey),textAlign: TextAlign.center,),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height* 0.065,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text(
                  'Back Home',style: mediumBold(primaryBlack),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

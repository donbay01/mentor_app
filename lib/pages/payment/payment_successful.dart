import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/text_style.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/Success.svg',height: 100,),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Payment successful',
                style: largeText(primaryBlack),
              ),
            ),
            SizedBox(height: 10,),
            Text('Thank you for using our platform, We hope you enjoy our services.',style: smallText(textGrey),textAlign: TextAlign.center,),
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
      ),
    );
  }
}

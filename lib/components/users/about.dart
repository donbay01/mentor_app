import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';

class About extends StatelessWidget {
  final UserModel user;

  const About({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Availability',
                style: small(),
              ),
              SizedBox(
                width: 20,
              ),
              Text('(this week)', style: small()),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Select one date you are comfortable with',
            style: small(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          // frame186hv2 (80:786)
          margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
          width: double.infinity,
          height: 75,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // frame184Q3k (80:787)
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                width: 103.67,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mon, 25th', style: small()),
                    Text(
                      // pm3pmp7U (80:789)
                      '2PM - 3PM',
                      style: small(),
                    ),
                  ],
                ),
              ),
              Container(
                // frame185mHc (80:790)
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                width: 103.67,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mon, 25th', style: small()),
                    Text(
                      // am11amoVC (80:792)
                      '10AM - 11AM',
                      style: small(),
                    ),
                  ],
                ),
              ),
              Container(
                // frame1868nN (80:793)
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                width: 103.67,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tue, 26th',
                      style: small(),
                    ),
                    Text(
                      // pm3pmCGS (80:795)
                      '2PM - 3PM',
                      style: small(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          // frame188k34 (80:796)
          margin: EdgeInsets.only(
            left: 16,
          ),
          width: double.infinity,
          height: 75,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                // frame184sNa (80:797)
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                width: 103,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fri, 29th', style: small()),
                    Text(
                      // pm8pmWRY (80:799)
                      '7PM - 8PM',
                      style: small(),
                    ),
                  ],
                ),
              ),
              Container(
                // frame185rkJ (80:800)
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                width: 103,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xfff2f3f6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sat, 30th', style: small()),
                    Text(
                      // pm1pmWpr (80:802)
                      '12PM - 1PM',
                      style: small(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class JobDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
          onPressed: () {
            // nav.setIndex(2);
            Navigator.pop(context);
          },
        ),
        title: Text('Community',style: mediumText(primaryBlue),),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/adaptLogo.png'
                          )
                      ),
                      SizedBox(width: 10),
                      Text('Data Analyst',style: mediumBold(primaryBlack),),
                    ],
                  ),
                  Text('Today',style: smallBold(greyText),),
                ],
              ),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              Text('We have a new role with an exciting fintech start-up in Nigeria, who are currently looking to hire a talented Digital Product designer to join their fast-growing team.',style: smallText(greyText),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.monetization_on_outlined),
                      SizedBox(width: 5,),
                      Text('100,000',style: smallText(greyText),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person_2_outlined,size: 20,),
                      SizedBox(width: 5,),
                      Text('2+ years',style: smallText(greyText),),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(
                'Job Descriptions',
                style: mediumBold(primaryBlack)
              ),
              SizedBox(height: 8.0),
              BulletList(
                items: [
                  'Develop and maintain web applications',
                  'Write clean, efficient, and well-documented code',
                  'Collaborate with cross-functional teams to define, design, and ship new features',
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Qualifications',
                style: mediumBold(primaryBlack),
              ),
              SizedBox(height: 8.0),
              BulletList(
                items: [
                  'Bachelor\'s degree in Computer Science or related field',
                  '3+ years of experience in web development',
                  'Strong knowledge of web technologies including HTML, CSS, JavaScript, and AJAX',
                  'Familiarity with web frameworks such as AngularJS, ReactJS, or VueJS',
                  'Experience with version control systems such as Git',
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: (){},
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: primaryBlue,
            ),
            child: Center(child: Text('Apply Now',style: mediumBold(primaryWhite),)),
          ),
        ),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;

  BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              '• ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(item,style: small(),),
          ),
        ],
      ))
          .toList(),
    );
  }
}

import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String _subscriptionType = "Free";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: primaryBlue,size: 15,),
        ),
        title: Text("Subscription",style: mediumText(primaryBlue),),
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
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color:greyText,width: 1)
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: Text("FREE"),
                        value: "Free",
                        groupValue: _subscriptionType,
                        onChanged: (value) {
                          setState(() {
                            _subscriptionType = value!;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.cancel,color: Colors.red,size: 15,),
                            SizedBox(width: 10,),
                            Text('Career sections',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.cancel,color: Colors.red,size: 15,),
                            SizedBox(width: 10,),
                            Text('Mock interviews',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.cancel,color: Colors.red,size: 15,),
                            SizedBox(width: 10,),
                            Text('Learning resources',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('Community (Job board & \nIndustry related articles)',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color:greyText,width: 1)
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: Text("MONTHLY"),
                        value: "Monthly",
                        groupValue: _subscriptionType,
                        onChanged: (value) {
                          setState(() {
                            _subscriptionType = value!;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                            child: Text('N5,000',style: large(),)),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('4 Career sections',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('2 Mock interviews',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('Learning resources',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('Community (Job board & \nIndustry related articles)',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width *0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color:greyText,width: 1)
                  ),
                  child: Column(
                    children: [
                      RadioListTile(
                        title: Text("BI-ANNUAL"),
                        value: "Bi-Annual",
                        groupValue: _subscriptionType,
                        onChanged: (value) {
                          setState(() {
                            _subscriptionType = value!;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('N25,000',style: large(),)),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('24 Career sections',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('7 Mock interviews',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('Learning resources',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: Colors.green,size: 15,),
                            SizedBox(width: 10,),
                            Text('Community (Job board & \nIndustry related articles)',style: small(),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width,
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

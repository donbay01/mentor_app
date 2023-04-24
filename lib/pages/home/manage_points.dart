import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class ManagePoints extends StatefulWidget {
  const ManagePoints({Key? key}) : super(key: key);

  @override
  State<ManagePoints> createState() => _ManagePointsState();
}

class _ManagePointsState extends State<ManagePoints> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlue,
            size: 20,
          ),
        ),
        title: Text(
          'Home',
          style: mediumText(primaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage account',
                style: large(),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bannerBlue.png'),
                  ),
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.coins,
                            color: primaryWhite,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Total Paddy Points',
                            style: smallBold(primaryWhite),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      Text(
                        '20000',
                        style: largeText(primaryWhite),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: primaryBlue,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '1 career section = 500 points',
                    style: smallText(primaryBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: size.height * 0.065,
                      width: size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: primaryBlue, width: 1),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Withdraw Points',
                              style: smallText(primaryBlue),
                            ),
                            Icon(
                              Icons.keyboard_double_arrow_up_rounded,
                              color: primaryBlue,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Edit Account',
                        style: smallText(primaryBlack),
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text('History',style: mediumBold(primaryBlack),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image(image: AssetImage('assets/jointavi.png')),
                          SizedBox(width: 10,),
                          Text('Mock Interview with Kokoma',style: smallText(textGrey),),
                        ],
                      ),
                      Text('Tues 25th | 10:00 - 10:30',style: smallText(textGrey),)
                    ],
                  ),
                  Text('+500 pts',style: smallText(Colors.green),)
                ],
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}

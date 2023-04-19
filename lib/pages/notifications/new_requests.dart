import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../theme/color.dart';

class SessionRequest extends StatefulWidget {
  const SessionRequest({Key? key}) : super(key: key);

  @override
  State<SessionRequest> createState() => _SessionRequestState();
}

class _SessionRequestState extends State<SessionRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: primaryBlack,
            size: 25,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: primaryBlack, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You have 4 new notifications',style: smallText(textGrey),),
              SizedBox(height: 20,),
              Text('TODAY',style: mediumBold(primaryBlack),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){

                },
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Image(image: AssetImage('assets/avatar.png'),),
                      radius: 30,
                    ),
                    SizedBox(width: 10,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'Chibuike sent you a',style: smallText(primaryBlack),),
                                TextSpan(text: ' career session request',style: smallText(primaryBlue))
                              ]
                            )
                        ),
                        SizedBox(height: 10,),
                        Text('4:30 PM')
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/adaptLogo.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac sent you a',style: smallText(primaryBlack),),
                                TextSpan(text: ' mMock interview request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac sent you a',style: smallText(primaryBlack),),
                                TextSpan(text: ' mock interview request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/adaptLogo.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac sent you a',style: smallText(primaryBlack),),
                                TextSpan(text: ' career session request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              SizedBox(height: 40,),


              //The ones below is accepted request which should be for the Mentee (Buddy)


              Text('THIS WEEK',style: mediumBold(primaryBlack),),
              SizedBox(height: 20,),
              Row(
                children: [
                  CircleAvatar(
                    child: Image(image: AssetImage('assets/avatar.png'),),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Chibuike accepted your',style: smallText(primaryBlack),),
                                TextSpan(text: ' career session request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('4:30 PM')
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/adaptLogo.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac accepted your',style: smallText(primaryBlack),),
                                TextSpan(text: ' mMock interview request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac accepted your',style: smallText(primaryBlack),),
                                TextSpan(text: ' mock interview request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/adaptLogo.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Isaac accepted your',style: smallText(primaryBlack),),
                                TextSpan(text: ' career session request',style: smallText(primaryBlue))
                              ]
                          )
                      ),
                      SizedBox(height: 10,),
                      Text('12:30 PM')
                    ],
                  )
                ],
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

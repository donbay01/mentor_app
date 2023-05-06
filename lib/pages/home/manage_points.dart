import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/date.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/pages/home/add_account.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:career_paddy/services/session.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import '../notifications/stacked_avatar.dart';

class ManagePoints extends StatefulWidget {
  const ManagePoints({Key? key}) : super(key: key);

  @override
  State<ManagePoints> createState() => _ManagePointsState();
}

class _ManagePointsState extends State<ManagePoints> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>().getUser;
    var size = MediaQuery.of(context).size;
    TextEditingController withdrawPointsController = TextEditingController();
    TextEditingController withdrawPasswordController = TextEditingController();


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
              if (user.role == MENTOR) ...[
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
                            ),
                          ],
                        ),
                        Text(
                          '${user.paddy_points}',
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
                      onTap: ()  {
                         showModalBottomSheet(
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                topLeft: Radius.circular(100),
                              ),
                            ),
                            context: context,
                            builder: (context)=> Container(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    Text('Withdraw Points',style: large(),),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.info_outline,color: greyText,size: 15,),
                                        SizedBox(width: 5,),
                                        Text('Min points you can withdraw is 2000 points',style: smallText(greyText),)
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    TextField(
                                      controller: withdrawPointsController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter withdrawal points',
                                        hintStyle: smallText(greyText),
                                        suffixIcon: withdrawPointsController.text.isEmpty
                                            ? Container(
                                          width: 0,
                                        )
                                            : IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            withdrawPointsController.clear();
                                          },
                                        ),
                                        filled: true,
                                        fillColor: primaryWhite,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: greyText,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: primaryBlue,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Center(child: Icon(Icons.swap_vert,size: 15,color: greyText,)),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context).size.height * 0.065,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: greyText),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text('Naira Equivalent',style: mediumText(greyText),)),
                                    ),
                                    SizedBox(height: 20,),
                                    TextField(
                                      controller: withdrawPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your withdrawal password',
                                        hintStyle: smallText(greyText),
                                        suffixIcon: withdrawPasswordController.text.isEmpty
                                            ? Container(
                                          width: 0,
                                        )
                                            : IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            withdrawPasswordController.clear();
                                          },
                                        ),
                                        filled: true,
                                        fillColor: primaryWhite,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: greyText,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: primaryBlue,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Cancel',
                                            style: mediumBold(Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Proceed',
                                            style: mediumBold(primaryBlue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));

                      },
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
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddAccount()));
                      },
                      child: Text(
                        'Add Account',
                        style: smallText(primaryBlack),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
              Text(
                'History',
                style: mediumBold(primaryBlack),
              ),
              SizedBox(
                height: 10,
              ),
              PaginateFirestore(
                isLive: true,
                separator: SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemBuilder: (context, snapshots, index) {
                  var snap = snapshots[index];
                  var session = SessionModel.fromJson(
                    snap.id,
                    snap.data() as dynamic,
                  );

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              StackedAvatars(
                                mentorImage: session.mentorImage,
                                menteeImage: session.menteeImage,
                                height: 40,
                                width: 60,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'A call with ${session.mentee}',
                                style: smallText(textGrey),
                              ),
                            ],
                          ),
                          Text(
                            '${DateHelper.formatShort(session.requestedAt.toDate())} | ${session.start} - ${session.end}',
                            style: smallText(textGrey),
                          ),
                        ],
                      ),
                      Text(
                        '+500 pts',
                        style: smallText(Colors.green),
                      ),
                    ],
                  );
                },
                query: SessionService.getHistory(user.uid),
                itemBuilderType: PaginateBuilderType.listView,
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController accountNameController = TextEditingController();
    TextEditingController bankNameController = TextEditingController();
    TextEditingController accountNumberController = TextEditingController();
    TextEditingController withdrawPasswordController = TextEditingController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  'My Account',
                  style: large(),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter your account details',
                  style: mediumText(textGrey),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Account number',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: accountNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter your account number',
                    hintStyle: smallText(greyText),
                    suffixIcon: accountNumberController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              accountNumberController.clear();
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Bank name',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: bankNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Bank name',
                    hintStyle: smallText(greyText),
                    suffixIcon: bankNameController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              bankNameController.clear();
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Account name',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: accountNumberController,
                  decoration: InputDecoration(
                    hintText: 'Enter your account number',
                    hintStyle: smallText(greyText),
                    suffixIcon: accountNumberController.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              accountNumberController.clear();
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Withdrawal Password',
                  style: mediumBold(textGrey),
                ),
                SizedBox(
                  height: 10,
                ),
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: primaryBlue,
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: mediumBold(primaryWhite),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

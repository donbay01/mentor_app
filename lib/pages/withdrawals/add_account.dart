import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/bank_account.dart';
import 'package:career_paddy/models/bank_model.dart';
import 'package:career_paddy/services/paystack.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class AddAccount extends StatefulWidget {
  final BankAccount? account;

  const AddAccount({
    Key? key,
    this.account,
  }) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  List<BankModel> banks = [];
  BankModel? dropdownvalue;
  final key = GlobalKey<FormState>();

  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController withdrawPasswordController = TextEditingController();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    getBanks();
    if (widget.account != null) {
      accountNameController.text = widget.account!.acc_name;
      accountNumberController.text = widget.account!.acc_no;
      withdrawPasswordController.text = widget.account!.password;
      // dropdownvalue = widget.account!.bank;
    }
    super.initState();
  }

  getBanks() async {
    try {
      banks = await PayStackService.getBanks();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    accountNameController.dispose();
    accountNumberController.dispose();
    withdrawPasswordController.dispose();
    super.dispose();
  }

  verifyAccount() async {
    var isValid = key.currentState!.validate();
    if (!isValid) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Fill in all required fields',
        primaryBlue,
      );
    }

    if (dropdownvalue == null) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Select your bank account',
        primaryBlue,
      );
    }

    try {
      await ProgressService.show(context);
      accountNameController.text = await PayStackService.verify(
        accountNumberController.text,
        dropdownvalue!.code,
        // dropdownvalue!.nuban!,
        // dropdownvalue!.currency,
      );
      await PayStackService.save(
        accountNameController.text,
        accountNumberController.text,
        withdrawPasswordController.text,
        dropdownvalue!,
      );
      await ProgressService.hide();
      SnackBarHelper.displayToastMessage(
        context,
        'Saved',
        primaryBlue,
      );
    } on FirebaseFunctionsException catch (e) {
      SnackBarHelper.displayToastMessage(
        context,
        e.message!,
        primaryBlue,
      );
      await ProgressService.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Form(
              key: key,
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
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
                  DropdownButton<BankModel>(
                    value: dropdownvalue,
                    hint: Text(
                      'Pick your bank',
                      style: medium(),
                    ),
                    items: banks.map((bank) {
                      return DropdownMenuItem(
                        value: bank,
                        child: Text(
                          bank.name,
                          style: smallBold(textGrey),
                        ),
                      );
                    }).toList(),
                    onChanged: (bank) {
                      setState(() {
                        dropdownvalue = bank!;
                      });
                    },
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
                    enabled: false,
                    controller: accountNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your account name',
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
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                    controller: withdrawPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Enter your withdrawal password',
                      hintStyle: smallText(greyText),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _toggle();
                        },
                        icon: _obscureText
                            ? const Icon(
                                FontAwesomeIcons.eyeSlash,
                                color: textGrey,
                                size: 15,
                              )
                            : const Icon(
                                Icons.remove_red_eye,
                                color: textGrey,
                                size: 20,
                              ),
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
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: verifyAccount,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: primaryBlue,
              ),
              child: Center(
                child: Text(
                  'Verify & Save',
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

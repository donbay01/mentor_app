import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/services/paystack.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class Converter extends StatefulWidget {
  final int points;

  const Converter({
    super.key,
    required this.points,
  });

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  TextEditingController withdrawPointsController = TextEditingController();
  TextEditingController withdrawPasswordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    withdrawPointsController.text = widget.points.toString();
    withdrawPointsController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    withdrawPointsController.removeListener(() {});
    withdrawPasswordController.dispose();
    withdrawPointsController.dispose();
    super.dispose();
  }

  proceed() async {
    var isValid = key.currentState?.validate();
    if (!isValid!) {
      return;
    }

    var points = withdrawPointsController.text;
    if (int.parse(points) < 2000) {
      return SnackBarHelper.displayToastMessage(
        context,
        'Min points: 2000',
        primaryBlue,
      );
    }

    try {
      await ProgressService.show(context);
      await PayStackService.withdraw(
        withdrawPasswordController.text,
        int.parse(withdrawPointsController.text),
      );
      await ProgressService.hide();
      Navigator.of(context).pop();
      SnackBarHelper.displayToastMessage(
        context,
        'Request sent',
        primaryBlue,
      );
    } on FirebaseFunctionsException catch (e) {
      await ProgressService.hide();
      // Navigator.of(context).pop();
      await SnackBarHelper.displayToastMessage(
        context,
        e.message!,
        primaryBlue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Withdraw Points',
                        style: large(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: greyText,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Min points you can withdraw is 2000 points',
                            style: smallText(greyText),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          var p = int.parse(value!);
                          if (p < 2000) {
                            return 'Min is 2000 points';
                          }
                          return null;
                        },
                        controller: withdrawPointsController,
                        keyboardType: TextInputType.number,
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
                        child: Center(
                          child: Icon(
                            Icons.swap_vert,
                            size: 15,
                            color: greyText,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.065,
                        width: size.width,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: greyText),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            withdrawPointsController.value.text.isEmpty
                                ? 'Naira Equivalent'
                                : 'N${withdrawPointsController.text}',
                            style: mediumText(greyText),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You need to enter your password';
                          }
                          return null;
                        },
                        controller: withdrawPasswordController,
                        obscureText: _obscureText,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: mediumBold(Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: proceed,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

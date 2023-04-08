import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/pages/Authentication/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var promoCode = TextEditingController();

  bool _obscureText = true;
  bool hasInternet = false;
  bool termsAndCondition = false;

  String? code;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _changeTerms(bool newValue) =>
      setState(() => termsAndCondition = newValue);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                height: height,
                width: width,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          width: 60.4,
                          height: 52.58,
                          child: SvgPicture.asset('assets/iconLogo.svg'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Let's create an account",
                          style: largeText(primaryBlack),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text('First Name',style: smallText(darkGrey),),
                        SizedBox(height: 5,),
                        TextFormField(
                          style: small(),
                          controller: firstNameController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            hintText: 'Your first name',
                            hintStyle: smallText(textGrey),
                            suffixIcon: firstNameController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      firstNameController.clear();
                                    },
                                  ),
                            filled: true,
                            fillColor: primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: darkBlue,
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Last Name',style: smallText(darkGrey),),
                        SizedBox(height: 5,),
                        TextFormField(
                          style: small(),
                          controller: lastNameController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            hintText: 'Your Last name',
                            hintStyle: smallText(textGrey),
                            suffixIcon: lastNameController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      lastNameController.clear();
                                    },
                                  ),
                            filled: true,
                            fillColor: primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: darkBlue,
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Email',style: smallText(darkGrey),),
                        SizedBox(height: 5,),
                        TextFormField(
                          style: small(),
                          controller: emailController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'paddy@gmail.com',
                            hintStyle: smallText(textGrey),
                            suffixIcon: emailController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      emailController.clear();
                                    },
                                  ),
                            filled: true,
                            fillColor: primaryWhite,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: darkBlue,
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
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Password',style: smallText(darkGrey),),
                        SizedBox(height: 5,),
                        TextField(
                          style: small(),
                          controller: passwordController,
                          obscureText: _obscureText,
                          autofillHints: [AutofillHints.password],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'xxxxxxxxxx',
                            hintStyle: smallText(textGrey),
                            filled: true,
                            fillColor: primaryWhite,
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: darkBlue,
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
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>const VerifyEmail()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            child: Text(
                              'Register',
                              style: medium(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          activeColor: primaryBlue,
                          checkColor: primaryWhite,
                          title: RichText(
                            text: TextSpan(
                              style: smallText(primaryBlack),
                              children: [
                                const TextSpan(
                                  text:
                                      'Creating an account means you agree with our',
                                ),
                                TextSpan(
                                  text: ' Terms of Service ',
                                  style: smallText(secondaryBlue),
                                ),
                                const TextSpan(
                                  text: 'and',
                                ),
                                TextSpan(
                                    text: ' Privacy Policy',
                                    style: smallText(secondaryBlue)),
                              ],
                            ),
                          ),
                          value: termsAndCondition,
                          onChanged: (newValue) {
                            setState(() {
                              termsAndCondition = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have have an account ?",
                              style: small(),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
                              },
                              child:  Text(
                                'Log in',
                                style: mediumText(secondaryBlue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 160,
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

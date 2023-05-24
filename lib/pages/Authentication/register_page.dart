import 'package:career_paddy/constants/message.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/pages/Authentication/verify_email.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../services/progress.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({
    Key? key,
    this.role = MENTEE,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var promoCode = TextEditingController();

  bool _obscureText = true;
  bool hasInternet = false;
  bool termsAndCondition = false;

  String? code;

  AuthService auth = AuthService();
  var checker = ConnectivityService();

  final _formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                          width: 60.4,
                          height: 52.58,
                          child: SvgPicture.asset('assets/iconLogo.svg'),
                        ),
                        Text(
                          "Let's create an account",
                          style: largeText(primaryBlack),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'First Name',
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          style: smallText(primaryBlack),
                          controller: firstNameController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            // labelText: 'First Name',
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
                        Text(
                          'Last Name',
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          style: smallText(primaryBlack),
                          controller: lastNameController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            // labelText: 'Last Name',
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
                        Text(
                          'Email',
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          style: smallText(primaryBlack),
                          controller: emailController,
                          autofillHints: [AutofillHints.email],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            // labelText: 'Email',
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
                        Text(
                          'Password',
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.length > 11) {
                              return 'Password must be a maximum of 11 characters';
                            }
                            return null;
                          },
                          style: smallText(primaryBlack),
                          controller: passwordController,
                          obscureText: _obscureText,
                          autofillHints: [AutofillHints.password],
                          onEditingComplete: () => [
                            // TextInput.finishAutofillContext(),
                            FocusScope.of(context).unfocus(),
                          ],
                          decoration: InputDecoration(
                            // labelText: 'Password',
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
                          height: 20,
                        ),
                        Text(
                          'Phone Number',
                          style: smallText(primaryBlack),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InternationalPhoneNumberInput(
                          onInputChanged: (value) {},
                          keyboardType: TextInputType.number,
                          textFieldController: phoneController,
                          initialValue: number,
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Kindly enter a valid number';
                            }

                            if (value.length > 14) {
                              return 'Kindly enter a valid number';
                            }

                            // return null;
                          },
                          formatInput: true,
                          ignoreBlank: false,
                          errorMessage: 'Kindly enter a valid number',
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          onSaved: (number) {
                            var text = phoneController.text;

                            if (!text.contains(number.dialCode!)) {
                              phoneController.text = number.phoneNumber!;
                            }
                          },
                          inputDecoration: InputDecoration(
                            hintText: '906 *** ****',
                            hintStyle: smallText(textGrey),
                            filled: true,
                            fillColor: primaryWhite,
                            suffixIcon: phoneController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      phoneController.clear();
                                    },
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
                          height: 20,
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
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
                                  style: smallText(secondaryBlue),
                                ),
                              ],
                            ),
                          ),
                          value: termsAndCondition,
                          onChanged: (newValue) {
                            setState(() {
                              termsAndCondition = newValue!;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              var isOnline = await checker.getConnection();
                              _formKey.currentState?.save();
                              var isValid = _formKey.currentState?.validate();
                              if (!isOnline) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'You are not connected to Internet at the moment. Kindly connect and try again later',
                                  primaryBlue,
                                );
                              } else if (firstNameController.text.isEmpty) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter your first Name',
                                  primaryBlue,
                                );
                              } else if (lastNameController.text.isEmpty) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter your Last Name',
                                  primaryBlue,
                                );
                              } else if (passwordController.text.isEmpty) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter a secure password',
                                  primaryBlue,
                                );
                              } else if (phoneController.text.isEmpty) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter your Phone Number',
                                  primaryBlue,
                                );
                              } else if (phoneController.text.length > 14) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter a valid Phone Number',
                                  primaryBlue,
                                );
                              } else if (!termsAndCondition) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  TA,
                                  primaryBlue,
                                );
                              } else if (passwordController.text.isEmpty) {
                                return SnackBarHelper.displayToastMessage(
                                  context,
                                  'Kindly enter your password',
                                  primaryBlue,
                                );
                              } else
                                try {
                                  if (!isValid!) {
                                    return SnackBarHelper.displayToastMessage(
                                      context,
                                      'Fill in required fields',
                                      primaryBlue,
                                    );
                                  }
                                  await ProgressService.show(context);
                                  var cred = await auth.createAccount(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    displayName:
                                        '${firstNameController.text} ${lastNameController.text}',
                                  );

                                  await auth.createProfile(
                                    first_name: firstNameController.text,
                                    last_name: lastNameController.text,
                                    // password: passwordController.text,
                                    email: emailController.text,
                                    role: widget.role,
                                    uid: cred.user!.uid,
                                    phone: phoneController.text,
                                  );

                                  await ProgressService.hide();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const VerifyEmail(),
                                    ),
                                  );
                                } catch (e) {
                                  var err = e as dynamic;
                                  await ProgressService.hide();
                                  SnackBarHelper.displayToastMessage(
                                    context,
                                    err.message,
                                    primaryBlue,
                                  );
                                }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Text(
                              'Create account',
                              style: medium(),
                            ),
                          ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Log in',
                                style: mediumText(primaryBlue),
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
      ),
    );
  }
}

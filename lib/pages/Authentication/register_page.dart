import 'package:career_paddy/components/loader/index.dart';
import 'package:career_paddy/constants/message.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/Authentication/login_page.dart';
import 'package:career_paddy/pages/Authentication/verify_email.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';

class RegisterScreen extends StatefulWidget {
  final String role;

  const RegisterScreen({
    Key? key,
    required this.role,
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
  bool isLoading = false;

  String? code;

  AuthService auth = AuthService();

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
        body: isLoading == false
            ? SingleChildScrollView(
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
                              height: 10,
                            ),
                            Text(
                              'First Name',
                              style: smallText(darkGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              style: small(),
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
                              height: 10,
                            ),
                            Text(
                              'Last Name',
                              style: smallText(darkGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              style: small(),
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
                              height: 10,
                            ),
                            Text(
                              'Email',
                              style: smallText(darkGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              style: small(),
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
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: smallText(darkGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
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
                              height: 10,
                            ),
                            Text(
                              'Phone Number',
                              style: smallText(darkGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InternationalPhoneNumberInput(
                              keyboardType: TextInputType.number,
                              textFieldController: phoneController,
                              initialValue: number,
                              formatInput: true,
                              ignoreBlank: false,
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              onInputChanged: (number) {
                                phoneController.text;
                              },
                              inputDecoration: InputDecoration(
                                hintText: '+234 906 *** ****',
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
                              height: 10,
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
                                  if (firstNameController.text.isEmpty) {
                                    return SnackBarHelper.displayToastMessage(
                                        context,
                                        'Kindly enter your first Name',
                                        primaryBlue);
                                  } else if (lastNameController.text.isEmpty) {
                                    return SnackBarHelper.displayToastMessage(
                                        context,
                                        'Kindly enter your Last Name',
                                        primaryBlue);
                                  } else if (passwordController.text.isEmpty) {
                                    return SnackBarHelper.displayToastMessage(
                                        context,
                                        'Kindly enter a secure password',
                                        primaryBlue);
                                  } else if (phoneController.text.isEmpty) {
                                    return SnackBarHelper.displayToastMessage(
                                        context,
                                        'Kindly enter your Phone Number',
                                        primaryBlue);
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
                                        primaryBlue);
                                  } else
                                    setState(() {
                                      isLoading = true;
                                    });
                                  try {
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const VerifyEmail(),
                                      ),
                                    );
                                  } catch (e) {
                                    var err = e as dynamic;
                                    SnackBarHelper.displayToastMessage(
                                      context,
                                      err.message,
                                      primaryBlue,
                                    );
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryBlue,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: Text(
                                  'Register',
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
              )
            : Center(
                child: Loader(),
              ),
      ),
    );
  }
}

import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/pages/Authentication/get_started.dart';
import 'package:career_paddy/pages/Authentication/register_page.dart';
import 'package:career_paddy/pages/Dashboard/dashboard_screen.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/services/connectivity.dart';
import 'package:career_paddy/services/progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/color.dart';
import '../../theme/text_style.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool signedIn = false;

  var service = AuthService();
  var checker = ConnectivityService();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
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
                    width: 60,
                    height: 60,
                    child: SvgPicture.asset('assets/iconLogo.svg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Welcome Back!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: darkBlue,
                        fontFamily: 'Gilroy'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter your details to continue',
                    style: smallText(darkBlue),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Email',
                    style: smallText(primaryBlack),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    style: small(),
                    controller: emailController,
                    autofillHints: const [AutofillHints.email],
                    onEditingComplete: () => [
                      // TextInput.finishAutofillContext(),
                      FocusScope.of(context).unfocus(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Enter e-mail',
                      hintText: 'mentor@gmail.com',
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
                    style: small(),
                    validator: (value) {
                      if (value!.length > 11) {
                        return 'Password must be a maximum of 11 characters';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: _obscureText,
                    autofillHints: [AutofillHints.password],
                    onEditingComplete: () => [
                      // TextInput.finishAutofillContext(),
                      FocusScope.of(context).unfocus(),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          value: signedIn,
                          contentPadding: EdgeInsets.zero,
                          activeColor: primaryBlue,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Transform.translate(
                            offset: Offset(-20, 0),
                            child: Text(
                              'Keep me signed in',
                              style: small(),
                            ),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              signedIn = newValue!;
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password ?',
                          style: smallBold(primaryBlue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        var isOnline = await checker.getConnection();
                        if (!isOnline) {
                          return SnackBarHelper.displayToastMessage(
                            context,
                            'You are not connected to Internet at the moment. Kindly connect and try again',
                            primaryBlue,
                          );
                        } else if (emailController.text.isEmpty) {
                          return SnackBarHelper.displayToastMessage(
                            context,
                            'Kindly enter your email',
                            primaryBlue,
                          );
                        } else if (passwordController.text.isEmpty) {
                          return SnackBarHelper.displayToastMessage(context,
                              'Kindly enter your password', primaryBlue);
                        } else
                          try {
                            await ProgressService.show(context);
                            await service.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            await ProgressService.hide();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Dashboard(),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            await ProgressService.hide();
                            SnackBarHelper.displayToastMessage(
                              context,
                              e.message!,
                              primaryBlue,
                            );
                          }
                      },
                      child: Text(
                        'Log in',
                        style: mediumBold(primaryWhite),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: small(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Create account',
                          style: smallBold(primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

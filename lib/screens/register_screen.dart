import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/app_dimension.dart';
import '../utils/enums.dart';
import '../widgets/auth_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Auth authType = Auth.login;

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: pageWidth * 0.45,
                  padding: EdgeInsets.only(
                    top: pageHeight * 0.08,
                    left: pageWidth * 0.036,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      authType == Auth.login
                          ? "Already \nhave an \naccount"
                          : "Create an \naccount",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: pageWidth * 0.398, top: pageHeight * 0.03),
                  child: SvgPicture.asset("assets/svg/reg_screen.svg"),
                )
              ],
            ),
            verticalSpacing(pageHeight * 0.012),
            AuthForm(
              authType: authType,
            ),
            Center(
              child: SizedBox(
                width: pageWidth * 0.56,
                height: pageHeight * 0.056,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondary),
                  ),
                  child: Text(
                    authType == Auth.login ? "Login" : "Sign Up",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(
                            fontSizeFactor: 1.25,
                            color: Theme.of(context).colorScheme.surfaceVariant)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    print("SignUp Tap");
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (authType == Auth.login) {
                    authType = Auth.signup;
                  } else {
                    authType = Auth.login;
                  }
                });
              },
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: Text(authType == Auth.login
                  ? "Don’t have an account? Sign Up"
                  : "Already Have an account? Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    thickness: pageWidth * 0.007,
                    indent: pageWidth * 0.097,
                    endIndent: pageWidth * 0.05,
                  ),
                ),
                Text(
                  "OR",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Divider(
                    thickness: pageWidth * 0.007,
                    indent: pageWidth * 0.05,
                    endIndent: pageWidth * 0.097,
                  ),
                )
              ],
            ),
            verticalSpacing(pageHeight * 0.018),
            authType == Auth.login
                ? SizedBox(
                    width: pageWidth * 0.475,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        loginButton(
                            pageHeight,
                            Icon(
                              Icons.phone,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            context),
                        loginButton(
                            pageHeight,
                            FaIcon(
                              FontAwesomeIcons.google,
                              color:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            context)
                      ],
                    ),
                  )
                : signUpGoogle(context),
          ],
        ),
      ),
    );
  }

  Widget loginButton(
    double pageHeight,
    Widget buttonIcon,
    BuildContext context,
  ) {
    return IconButton.filled(
      iconSize: pageHeight * 0.035,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
      ),
      onPressed: () {},
      icon: buttonIcon,
    );
  }

  Widget signUpGoogle(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    //TODO -> Change Row at line 188 to FilledButton.icon and use FaIcon (ex. at line 141)

    return SizedBox(
      width: pageWidth * 0.62,
      height: pageHeight * 0.056,
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll(Theme.of(context).colorScheme.secondary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/svg/google.svg",
              width: pageWidth * 0.05,
              height: pageHeight * 0.04,
            ),
            const Spacer(),
            SizedBox(
              width: pageWidth * 0.45,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Sign Up with Google",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          fontWeight: FontWeight.bold)
                      .apply(fontSizeFactor: 1.125),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        onPressed: () {
          print("SignUpGoogle Tap");
        },
      ),
    );
  }
}

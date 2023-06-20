import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth_service.dart';
import '../utils/app_dimension.dart';
import '../utils/enums.dart';

class AuthForm extends StatefulWidget {
  final Auth authType;
  final void Function(
    String email,
    String pass,
    String first,
    String last,
    Auth auth,
  ) submitForm;
  final void Function(Auth authType) screenChange;
  const AuthForm({
    super.key,
    required this.authType,
    required this.submitForm,
    required this.screenChange,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _authForm = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confPass = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  RegExp r1 = RegExp(r'(?=.*?[0-9]).{6,}$');

  void formValidate() {
    final valid = _authForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (valid) {
      _authForm.currentState!.save();
      widget.submitForm(
        email.text.trim(),
        pass.text.trim(),
        firstName.text.trim(),
        lastName.text.trim(),
        widget.authType,
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.097),
      width: pageWidth,
      // height: pageHeight * 0.4,
      child: Column(
        children: [
          Form(
            key: _authForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.authType == Auth.signup)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "First Name",
                                //   style: Theme.of(context).textTheme.bodyLarge,
                                // ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "First Name cannot be empty";
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return "Name can contain only letters.";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: pageHeight * 0.001,
                                    ),
                                    errorMaxLines: 2,
                                    label: Text(
                                      "First Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                  controller: firstName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white)
                                      .apply(fontSizeFactor: 1.125),
                                ),
                              ],
                            ),
                          ),
                          horizontalSpacing(pageWidth * 0.07),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   "Last Name",
                                //   style: Theme.of(context).textTheme.bodyLarge,
                                // ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: lastName,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Last Name cannot be empty";
                                    } else if (!RegExp(r'^[a-zA-Z]+$')
                                        .hasMatch(value)) {
                                      return "Name can contain only letters.";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: pageHeight * 0.001,
                                    ),
                                    label: Text(
                                      "Last Name",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white)
                                      .apply(fontSizeFactor: 1.125),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                verticalSpacing(pageHeight * 0.03),
                // Text(
                //   "Email",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@') ||
                        !value.contains('.')) {
                      return 'Please enter a valid email!';
                    }
                    return null;
                  },
                  controller: email,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: pageHeight * 0.001,
                    ),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white)
                      .apply(fontSizeFactor: 1.125),
                ),
                verticalSpacing(pageHeight * 0.03),
                // Text(
                //   "Password",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                  obscureText: _obscure1,
                  obscuringCharacter: '*',
                  controller: pass,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a password!";
                    } else if (!r1.hasMatch(value) &&
                        widget.authType == Auth.signup) {
                      return "Please enter at least 1 number and 6 or more characters!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: pageHeight * 0.001,
                    ),
                    suffixIcon: IconButton(
                      icon: _obscure1
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscure1 = !_obscure1;
                        });
                      },
                    ),
                  ),
                ),
                if (widget.authType == Auth.signup)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacing(pageHeight * 0.03),
                      // Text(
                      //   "Confirm Password",
                      //   style: Theme.of(context).textTheme.bodyLarge,
                      // ),
                      TextFormField(
                        obscureText: _obscure2,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != pass.text) {
                            return "Passwords do not match!";
                          }
                          return null;
                        },
                        obscuringCharacter: '*',
                        controller: confPass,
                        decoration: InputDecoration(
                          label: Text(
                            "Confirm Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: pageHeight * 0.001,
                          ),
                          suffixIcon: IconButton(
                            icon: _obscure2
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscure2 = !_obscure2;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                verticalSpacing(
                  widget.authType == Auth.login
                      ? pageHeight * 0.07
                      : pageHeight * 0.025,
                ),
              ],
            ),
          ),
          verticalSpacing(pageHeight * 0.02),
          Center(
            child: SizedBox(
              width: pageWidth * 0.56,
              height: pageHeight * 0.056,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
                ),
                onPressed: formValidate,
                child: Text(
                  widget.authType == Auth.login ? "Login" : "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(
                          fontSizeFactor: 1.25,
                          color: Theme.of(context).colorScheme.surfaceVariant)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              widget.screenChange(widget.authType);
            },
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            child: Text(widget.authType == Auth.login
                ? "Don't have an account? Sign Up"
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
          widget.authType == Auth.login
              ? SizedBox(
                  width: pageWidth * 0.475,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loginButton(
                          pageHeight,
                          Icon(
                            Icons.phone,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                          () {},
                          context),
                      loginButton(
                          pageHeight,
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ), () {
                        try {
                          AuthService().signInWithGoogle();
                        } on PlatformException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.message!,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                            ),
                          );
                        }
                      }, context)
                    ],
                  ),
                )
              : signUpGoogle(context),
        ],
      ),
    );
  }

  Widget loginButton(
    double pageHeight,
    Widget buttonIcon,
    void Function() onPressed,
    BuildContext context,
  ) {
    return IconButton.filled(
      iconSize: pageHeight * 0.035,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
      ),
      onPressed: onPressed,
      icon: buttonIcon,
    );
  }

  Widget signUpGoogle(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return SizedBox(
        width: pageWidth * 0.62,
        height: pageHeight * 0.056,
        child: FilledButton.icon(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: Theme.of(context).colorScheme.surfaceVariant,
          ),
          label: Text(
            "Sign Up with Google",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    fontWeight: FontWeight.bold)
                .apply(fontSizeFactor: 1.125),
          ),
        ));
  }
}

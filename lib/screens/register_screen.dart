// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    final firebaseAuth = FirebaseAuth.instance;
    UserCredential userCred;

    void submit(
      String email,
      String pass,
      String first,
      String last,
      Auth auth,
    ) async {
      if (auth == Auth.login) {
        try {
          userCred = await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: pass);
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.message!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      } else {
        try {
          userCred = await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: pass);
          userCred.user!.updateDisplayName("$first $last");
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.message!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      }
    }

    void stateChange(Auth authT) {
      setState(() {
        if (authT == Auth.login) {
          authType = Auth.signup;
        } else {
          authType = Auth.login;
        }
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                submitForm: submit,
                screenChange: stateChange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

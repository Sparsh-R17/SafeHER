import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_dimension.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _authForm = GlobalKey<FormState>();
  bool _obscure1 = true;
  bool _obscure2 = true;
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
                    top: pageHeight * 0.11,
                    left: pageWidth * 0.036,
                  ),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Create an \naccount",
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.097),
              width: pageWidth,
              height: pageHeight * 0.4,
              child: Form(
                key: _authForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)
                          .apply(fontSizeFactor: 1.125),
                    ),
                    verticalSpacing(pageHeight * 0.015),
                    Text(
                      "Email",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)
                          .apply(fontSizeFactor: 1.125),
                    ),
                    verticalSpacing(pageHeight * 0.015),
                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                      obscureText: _obscure1,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
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
                    verticalSpacing(pageHeight * 0.015),
                    Text(
                      "Confirm Password",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      obscureText: _obscure2,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
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
              ),
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
                    "Sign Up",
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
                print("TextButton Tap");
              },
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: const Text("Already Have an account? Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Divider(
                  thickness: pageWidth * 0.007,
                  indent: pageWidth * 0.097,
                  endIndent: pageWidth * 0.05,
                )),
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
            SizedBox(
              width: pageWidth * 0.62,
              height: pageHeight * 0.056,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondary),
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
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
            ),
          ],
        ),
      ),
    );
  }
}

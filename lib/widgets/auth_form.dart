import 'package:flutter/material.dart';

import '../utils/app_dimension.dart';
import '../utils/enums.dart';

class AuthForm extends StatefulWidget {
  final Auth authType;
  const AuthForm({
    super.key,
    required this.authType,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _authForm = GlobalKey<FormState>();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.097),
      width: pageWidth,
      // height: pageHeight * 0.4,
      child: Form(
        key: _authForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.authType == Auth.signup)
              Column(
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
                ],
              ),
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
            if (widget.authType == Auth.signup)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            verticalSpacing(
              widget.authType == Auth.login
                  ? pageHeight * 0.07
                  : pageHeight * 0.025,
            ),
          ],
        ),
      ),
    );
  }
}

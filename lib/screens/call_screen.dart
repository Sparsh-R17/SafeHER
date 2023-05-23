import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/app_dimension.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    String phoneNumber = "+91 9642389700";

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Call Manager',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: pageWidth * 0.08, top: pageHeight * 0.0438),
            width: pageWidth * 0.35,
            child: FittedBox(
              child: Text(
                "Fake Call",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          verticalSpacing(pageHeight * 0.03),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.08),
              child: TextFormField(
                initialValue: phoneNumber,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).nextFocus();
                },
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration(
                    label: const Text("Name"),
                    border: const OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: pageWidth * 0.04,
                        vertical: pageHeight * 0.025),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {},
                    )),
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: pageWidth * 0.108, top: pageHeight * 0.01),
            width: pageWidth * 0.8,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "Enter the name/number of the fake caller",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: pageWidth * 0.08,
                  top: pageHeight * 0.035,
                  right: pageWidth * 0.08),
              child: TextFormField(
                style: Theme.of(context).textTheme.titleMedium,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: pageWidth * 0.04,
                      vertical: pageHeight * 0.025),
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: pageWidth * 0.108, top: pageHeight * 0.01),
            width: pageWidth * 0.65,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Edit the password",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: pageWidth * 0.08, top: pageHeight * 0.04),
                width: pageWidth * 0.6,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Add recording for the call",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: pageHeight * 0.04, right: pageWidth * 0.09),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                            Size(pageWidth * 0.139, pageHeight * 0.0625)),
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondary),
                        shape: const MaterialStatePropertyAll(CircleBorder())),
                    child: Icon(
                      Icons.mic,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      size: pageWidth * 0.08,
                    ),
                  )),
            ],
          ),
          verticalSpacing(pageHeight * 0.04),
          Center(
              child: OutlinedButton(
            onPressed: () {},
            style: ButtonStyle(
                side: MaterialStatePropertyAll(
                  BorderSide(
                      color: Theme.of(context).colorScheme.secondary, width: 2),
                ),
                minimumSize: MaterialStatePropertyAll(
                    Size(pageWidth * 0.25, pageHeight * 0.062)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)))),
            child: Text(
              "Start",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          )),
          verticalSpacing(pageHeight * 0.04),
          Center(
            child: SizedBox(
              width: pageWidth * 0.475,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "For Emergency Services",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          verticalSpacing(pageHeight * 0.005),
          Center(
            child: SizedBox(
              height: pageHeight * 0.085,
              width: pageWidth * 0.43,
              child: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/svg/e911.svg",
                  fit: BoxFit.scaleDown,
                  width: pageWidth * 0.138,
                  height: pageHeight * 0.0625,
                ),
                label: Padding(
                  padding: EdgeInsets.only(left: pageWidth * 0.02),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Call 911',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500)
                          .apply(fontSizeFactor: 1.2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

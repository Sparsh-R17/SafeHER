import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kavach/screens/main_screen.dart';
import 'package:kavach/utils/app_dimension.dart';
import 'package:kavach/utils/sos_fn.dart';
import 'package:provider/provider.dart';

import '../providers/trigger.dart';

class TriggerScreen extends StatefulWidget {
  const TriggerScreen({super.key});

  @override
  State<TriggerScreen> createState() => _TriggerScreenState();
}

class _TriggerScreenState extends State<TriggerScreen> {
  int _val = 5;
  Timer? timer;
  bool showDismiss = true;

  void timerStart() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_val == 0) {
          Provider.of<Trigger>(context, listen: false).timedOutAlert();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ));
          timer!.cancel();
        } else {
          _val = _val - 1;
        }
      });
    });
  }

  @override
  void initState() {
    timerStart();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trigger = Provider.of<Trigger>(context);
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: pageWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: pageHeight * 0.046),
                child: const Text(
                  "Emergency SOS",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: pageHeight * 0.046, left: pageWidth * 0.170),
                child: tickText("Share location with contact"),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: pageHeight * 0.038, left: pageWidth * 0.170),
                child: tickText("Record video"),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: pageHeight * 0.038, left: pageWidth * 0.170),
                child: tickText("Record audio"),
              ),
              Padding(
                padding: EdgeInsets.only(top: pageHeight * 0.05),
                child: Text(
                  '$_val',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 250,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (showDismiss)
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.only(left: pageWidth * 0.05),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: const Color(0xffF9DEDC)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.17),
                    child: Dismissible(
                      key: const ValueKey("Dismiss"),
                      onDismissed: (direction) {
                        trigger.alertTrigger();
                        timer!.cancel();
                        sendSOS(true);
                        setState(() => showDismiss = !showDismiss);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ));
                      },
                      direction: DismissDirection.startToEnd,
                      child: Container(
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.8),
                        child: const Icon(
                          Icons.cancel,
                          size: 70,
                          color: Color(0xff8C1D18),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tickText(String content) {
    return Row(
      children: [
        const Icon(
          Icons.done,
          color: Colors.white,
        ),
        horizontalSpacing(10),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

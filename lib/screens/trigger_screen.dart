import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trigger.dart';

class TriggerScreen extends StatelessWidget {
  const TriggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _trigger = Provider.of<Trigger>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _trigger.alertTrigger,
          child: const Text('Exit'),
        ),
      ),
    );
  }
}

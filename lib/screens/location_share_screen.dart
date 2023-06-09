import 'package:flutter/material.dart';

class LocationShareScreen extends StatefulWidget {
  final String reason;
  final Duration duration;
  const LocationShareScreen({
    super.key,
    required this.reason,
    required this.duration,
  });

  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("You have started to share your live location!"),
          Text("Reason:${widget.reason}"),
          Text(
            "Duration:${widget.duration.inHours} Hours and ${widget.duration.inMinutes.remainder(60)} minutes",
          ),
        ],
      ),
    );
  }
}

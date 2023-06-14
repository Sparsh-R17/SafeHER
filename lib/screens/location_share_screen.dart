import 'package:flutter/material.dart';
import 'package:kavach/utils/app_dimension.dart';
import 'package:kavach/utils/sos_fn.dart';

class LocationShareScreen extends StatefulWidget {
  final String reason;
  final Duration duration;
  final List<String> nos;
  const LocationShareScreen({
    super.key,
    required this.reason,
    required this.duration,
    required this.nos,
  });

  @override
  State<LocationShareScreen> createState() => _LocationShareScreenState();
}

class _LocationShareScreenState extends State<LocationShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("You have started to share your live location!"),
            Text("Reason:${widget.reason}"),
            Text(
              "Duration:${widget.duration.inHours} Hours and ${widget.duration.inMinutes.remainder(60)} minutes",
            ),
            verticalSpacing(10),
            ElevatedButton(
              onPressed: () {
                shareLocation(widget.nos, true, "Travel Finished");
                Navigator.pop(context);
              },
              child: const Text("Stop Sharing"),
            )
          ],
        ),
      ),
    );
  }
}

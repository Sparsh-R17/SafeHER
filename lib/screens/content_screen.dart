import 'package:flutter/material.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool keyboardIs = false;
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView.builder(
          itemCount: 1000,
          itemBuilder: (context, index) {
            return Text("Hello ${index + 1}");
          }),
      bottomNavigationBar: Container(
        height: pageHeight * 0.08,
        padding: EdgeInsets.symmetric(
          horizontal: pageWidth * 0.03,
          vertical: pageHeight * 0.01,
        ),
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.primary.withOpacity(0.08),
          Theme.of(context).colorScheme.surface,
        ),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_added),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

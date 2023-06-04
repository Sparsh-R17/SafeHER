import 'package:flutter/material.dart';

class InfoTile extends StatefulWidget {
  const InfoTile(
      {super.key,
      required this.pageHeight,
      required this.icon,
      required this.data,
      required this.med,
      this.route,
      this.subtitle,
      this.index});

  final double pageHeight;
  final IconData icon;
  final String data;
  final String? subtitle;
  final String? route;
  final bool med;
  final int? index;

  @override
  State<InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<InfoTile> {
  List<String> bloodType = [
    'Unknown',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  String selectedBlood = 'Unknown';

  TextEditingController allergies = TextEditingController(text: 'N/A');
  TextEditingController medication = TextEditingController(text: 'N/A');
  TextEditingController history = TextEditingController(text: 'N/A');
  TextEditingController familyDoctor = TextEditingController(text: 'N/A');

  late List fields = [
    allergies,
    medication,
    history,
    familyDoctor,
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    allergies.dispose();
    medication.dispose();
    history.dispose();
    familyDoctor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return ListTile(
        leading: Padding(
          padding: widget.med
              ? EdgeInsets.only(left: pageWidth * 0.01, right: pageWidth * 0.02)
              : EdgeInsets.zero,
          child: Icon(
            widget.icon,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            size: widget.pageHeight * 0.03,
          ),
        ),
        title: Text(
          widget.data,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: widget.med ? FontWeight.w500 : FontWeight.normal),
        ),
        subtitle: widget.med
            ? Text(
                widget.subtitle!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              )
            : null,
        onTap: () {
          if (widget.med == false) {
            Navigator.pushNamed(context, widget.route!);
          } else {
            if (widget.index == 0) {
              bloodSelection(context);
            } else {
              textDataInput(context, widget.index!);
            }
          }
        });
  }

  Future<dynamic> bloodSelection(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              title: const Text('Choose your Blood Type'),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: bloodType.map((e) {
                          return RadioListTile.adaptive(
                            value: e,
                            groupValue: selectedBlood,
                            onChanged: (val) {
                              setState(() {
                                selectedBlood = val!;
                              });
                            },
                            title: Text(e),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: pageWidth * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              print(selectedBlood);
                              Navigator.pop(context);
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<dynamic> textDataInput(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Enter ${widget.data}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: TextField(
            controller: fields[index - 1],
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

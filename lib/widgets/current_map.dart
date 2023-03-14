import 'package:flutter/material.dart';
import 'package:kavach/utils/app_dimension.dart';

class CurrentMap extends StatefulWidget {
  const CurrentMap({super.key});

  @override
  State<CurrentMap> createState() => _CurrentMapState();
}

class _CurrentMapState extends State<CurrentMap> {
  final List<int> _chipIndex = [];

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: pageHeight * 0.45,
          width: pageWidth * 0.9,
          child: const Card(
            child: Center(
              child: Text('Current Location'),
            ),
          ),
        ),
        verticalSpacing(pageHeight * 0.01),
        SizedBox(
          height: pageHeight * 0.1,
          width: pageWidth * 0.9,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.015,
                ),
                child: ActionChip(
                  avatar: const Icon(
                    Icons.car_crash,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_chipIndex.contains(index)) {
                        _chipIndex.remove(index);
                      } else {
                        _chipIndex.add(index);
                      }
                    });
                  },
                  side: _chipIndex.contains(index) ? BorderSide.none : null,
                  backgroundColor: _chipIndex.contains(index)
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : null,
                  label: const Text('Police'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

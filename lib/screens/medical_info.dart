import 'package:flutter/material.dart';
import '../utils/app_dimension.dart';
import '../widgets/info_tile.dart';

class MedInfo {
  final IconData icon;
  final String text;
  final String subtitle;

  MedInfo({
    required this.icon,
    required this.text,
    required this.subtitle,
  });
}

class MedicalInfo extends StatefulWidget {
  const MedicalInfo({super.key});
  static const routeName = '/med-info';
  @override
  State<MedicalInfo> createState() => _MedicalInfoState();
}

class _MedicalInfoState extends State<MedicalInfo> {
  List<MedInfo> info = [
    MedInfo(icon: Icons.bloodtype_outlined, text: "Blood Type", subtitle: "B+"),
    MedInfo(
        icon: Icons.medical_information_outlined,
        text: "Allergies",
        subtitle: "Dust allergy, Pollen allergies"),
    MedInfo(
        icon: Icons.vaccines_outlined,
        text: "Ongoing Medication",
        subtitle: "Serotonin"),
    MedInfo(
        icon: Icons.history_toggle_off_outlined,
        text: "Past Medical History",
        subtitle: "NA"),
    MedInfo(
        icon: Icons.medical_services_outlined,
        text: "Family Doctor Info",
        subtitle: "NA"),
  ];

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            top: pageHeight * 0.0225,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: pageWidth * 0.0638),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: pageHeight * 0.04,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: pageHeight * 0.03),
                child: Center(
                  child: SizedBox(
                    width: pageWidth * 0.83,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Medical Information",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpacing(pageHeight * 0.04),
              Padding(
                padding: EdgeInsets.only(left: pageWidth * 0.1),
                child: ListTile(
                  leading: Image.asset(
                    "assets/png/avatar_1.png",
                    width: pageWidth * 0.112,
                    height: pageHeight * 0.05,
                  ),
                  title: Text(
                    "Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Ayushri Bhuyan",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: pageWidth * 0.1),
                child: ListTile(
                  leading: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: pageWidth * 0.022),
                    child: Icon(
                      Icons.home_outlined,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      size: pageHeight * 0.03,
                    ),
                  ),
                  title: Text(
                    "Address",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "Girls Hostel, VIT Bhopal, MP",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: pageWidth * 0.066,
                ),
                child: Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: pageWidth * 0.116),
                child: ListView.builder(
                  itemCount: info.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InfoTile(
                      icon: info[index].icon,
                      pageHeight: pageHeight,
                      data: info[index].text,
                      subtitle: info[index].subtitle,
                      med: true,
                      index: index,
                    );
                  },
                ),
              ),
              verticalSpacing(pageHeight * 0.048),
              Container(
                margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.094),
                padding: EdgeInsets.symmetric(
                    horizontal: pageWidth * 0.03, vertical: pageHeight * 0.015),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xffCAC4D0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: const Color(0xffAEAAAE),
                      size: pageHeight * 0.02,
                    ),
                    horizontalSpacing(pageWidth * 0.025),
                    Text(
                      "This information will be saved on the local\n device.",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

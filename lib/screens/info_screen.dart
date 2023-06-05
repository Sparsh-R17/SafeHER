import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/app_dimension.dart';
import '../widgets/info_tile.dart';
import 'checklist_screen.dart';
import 'community_screen.dart';
import 'emergency_contacts.dart';
import 'medical_info.dart';

class InfoData {
  final IconData icon;
  final String text;
  final String pageRoute;

  InfoData({
    required this.icon,
    required this.text,
    required this.pageRoute,
  });
}

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<InfoData> infoData = [
    InfoData(
      icon: Icons.medical_services_outlined,
      text: "Medical Information",
      pageRoute: MedicalInfo.routeName,
    ),
    InfoData(
      icon: Icons.contact_emergency_outlined,
      text: "Emergency Contacts",
      pageRoute: EmergencyContacts.routeName,
    ),
    InfoData(
      icon: Icons.checklist_outlined,
      text: "Checklist",
      pageRoute: CheckListScreen.routeName,
    ),
    InfoData(
      icon: Icons.storefront_outlined,
      text: "Community",
      pageRoute: CommunityScreen.routeName,
    ),
    InfoData(
      icon: Icons.hiking_outlined,
      text: "Tracking",
      pageRoute: EmergencyContacts.routeName,
    ),
    InfoData(
      icon: Icons.settings_outlined,
      text: "Settings",
      pageRoute: EmergencyContacts.routeName,
    )
  ];
  String provider = "";
  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

    var user = FirebaseAuth.instance.currentUser!;
    for (final i in user.providerData) {
      provider = i.providerId;
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  // verticalSpacing(pageHeight * 0.0625),
                  Align(
                    alignment: Alignment.topRight,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                        onPressed: () {
                          if (provider == "google.com") {
                            GoogleSignIn().signOut();
                            FirebaseAuth.instance.signOut();
                          } else {
                            FirebaseAuth.instance.signOut();
                          }
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout'),
                        style: ButtonStyle(
                          iconColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.tertiary,
                          ),
                          foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Image.asset(
                    "assets/png/avatar_1.png",
                    width: pageWidth * 0.325,
                    height: pageHeight * 0.14625,
                  ),
                  verticalSpacing(pageHeight * 0.0325),
                  Text(
                    user.displayName!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpacing(pageHeight * 0.02875),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: pageWidth * 0.049),
                    padding: EdgeInsets.symmetric(
                        horizontal: pageWidth * 0.0639,
                        vertical: pageHeight * 0.015),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffCAC4D0))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your personal details for your safety",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          verticalSpacing(pageHeight * 0.00875),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: const Color(0xffAEAAAE),
                                size: pageHeight * 0.02,
                              ),
                              horizontalSpacing(pageWidth * 0.025),
                              Text(
                                "Info is saved on this device",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: const Color(0xffAEAAAE),
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          )
                        ]),
                  ),
                ],
              ),
              verticalSpacing(pageHeight * 0.025),
              Text(
                "Personal Information",
                textAlign: TextAlign.left,
                textScaleFactor: 1.1,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              // verticalSpacing(pageHeight * 0.01),
              ListTile(
                leading: Icon(
                  Icons.contact_phone_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  size: pageHeight * 0.03,
                ),
                title: Text(
                  "Contact Number",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  "987654321",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  size: pageHeight * 0.03,
                ),
                title: Text(
                  "Address",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  "Girls Hostel VIT Bhopla",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: pageWidth * 0.03,
                  right: pageWidth * 0.03,
                  // top: pageHeight * 0.00625,
                ),
                child: Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              ListView.builder(
                itemCount: infoData.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InfoTile(
                    pageHeight: pageHeight,
                    data: infoData[index].text,
                    icon: infoData[index].icon,
                    route: infoData[index].pageRoute,
                    med: false,
                  );
                },
              )
              // infoTile(pageHeight: pageHeight, icon: Icons.abc, data: "hghg")
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../utils/app_dimension.dart';

import 'emergency_contacts.dart';

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
      pageRoute: EmergencyContacts.routeName,
    ),
    InfoData(
      icon: Icons.contact_emergency_outlined,
      text: "Emergency Contacts",
      pageRoute: EmergencyContacts.routeName,
    ),
    InfoData(
      icon: Icons.checklist_outlined,
      text: "Checklist",
      pageRoute: EmergencyContacts.routeName,
    ),
    InfoData(
      icon: Icons.storefront_outlined,
      text: "Community",
      pageRoute: EmergencyContacts.routeName,
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

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    final pageWidth = MediaQuery.of(context).size.width;

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
                        onPressed: () {},
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
                    "Ayushri Bhuyan",
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
                                    .labelMedium
                                    ?.copyWith(
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
                  Icons.home,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  size: pageHeight * 0.03,
                ),
                title: Text(
                  "Address",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Text(
                  "Baba babham bole street",
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
                  return infoTile(
                    pageHeight: pageHeight,
                    data: infoData[index].text,
                    icon: infoData[index].icon,
                    route: infoData[index].pageRoute,
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

class infoTile extends StatelessWidget {
  const infoTile({
    super.key,
    required this.pageHeight,
    required this.icon,
    required this.data,
    required this.route,
  });

  final double pageHeight;
  final IconData icon;
  final String data;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        size: pageHeight * 0.03,
      ),
      title: Text(
        data,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () => Navigator.pushNamed(
        context,
        EmergencyContacts.routeName,
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/db/categorydb/transactiondb/transactiondb.dart';
import 'package:mymoney/screens/about.dart';
import 'package:mymoney/screens/feedback.dart';
import 'package:mymoney/screens/privacy_policy.dart';
import 'package:mymoney/screens/terms_and_conditions.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:mymoney/screens/widgets/notification_class.dart';

import '../theme/color_theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool light = true;
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: ColorTheme.whiteColor,
        // ),
        title: Text('Settings',
            style: CustomTextStyles.titleText.copyWith(
              color: ColorTheme.whiteColor,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: ColorTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 25,
              decoration: BoxDecoration(
                  color: ColorTheme.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(40))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Iconsax.notification),
                      title: const Text('Notification'),
                      trailing: Switch(
                        // This bool value toggles the switch.
                        value: light,

                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.

                          setState(() {
                            light = value;
                          });
                          if (value == true) {
                            // NotificationServices().periodicalshowNotification(
                            //     ctx: context,
                            //     title: 'Reminder',
                            //     body: 'dont forget to add transaction');
                          } else {
                            // NotificationServices().stopNotification();
                          }
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Iconsax.refresh),
                      title: const Text('App reset'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete all data?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Transactiondb.instance.reset();

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Iconsax.share),
                      title: Text('Share app'),
                    ),
                  ),
                  const Card(
                    child: ListTile(
                      leading: Icon(Iconsax.star),
                      title: Text('Rate app'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Iconsax.document),
                      title: const Text('Terms and Conditions'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TandC(),
                            ));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Iconsax.lock),
                      title: const Text('Privacy Policy'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TermsAndConditons(),
                            ));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );
                      },
                      leading: const Icon(Iconsax.message),
                      title: const Text('Feedback'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About()),
                        );
                      },
                      leading: const Icon(Iconsax.info_circle),
                      title: const Text('About Us'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

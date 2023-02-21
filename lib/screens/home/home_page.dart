import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mymoney/screens/home/charts.dart';
import 'package:mymoney/screens/home/green_list.dart';

import 'package:mymoney/theme/color_theme.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../widgets/notification_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/logo-color_preview_rev_1.png',
                height: 30,
                width: 100,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.profile_add,
                    color: Colors.blue,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Refer a friend',
                        style: CustomTextStyles.h4Text.copyWith(
                          color: ColorTheme.buttonColor,
                        )),
                  )
                ],
              )
            ],
          ),
          const Greenboard(),
          const SizedBox(height: 13),
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Star Bucks',
                    style: CustomTextStyles.h3Text,
                  ),
                  const Text('₹799'),
                ],
              )
            ],
          ),
          CustomChoice(
            selectcolor: ColorTheme.primaryColor,
            backcolor: ColorTheme.whiteColor,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 8,
                decoration: BoxDecoration(
                    color: ColorTheme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spending',
                    style: CustomTextStyles.h2Text,
                  ),
                  Text(
                    '₹8799',
                    style: CustomTextStyles.h2Text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.primaryColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 8,
                decoration: BoxDecoration(
                    color: ColorTheme.buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Count',
                    style: CustomTextStyles.h2Text,
                  ),
                  Text(
                    '49',
                    style: CustomTextStyles.h2Text.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.buttonColor),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          const BarChartSample3(),
        ],
      )),
    );
  }
}

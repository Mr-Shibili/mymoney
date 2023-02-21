import 'package:flutter/material.dart';
import 'package:mymoney/theme/color_theme.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/logo-color_preview_rev_1.png',
              width: 180,
              height: 100,
            ),
            Text('Put money back in\nyour pocket',
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleText
                    .copyWith(fontWeight: FontWeight.bold)),
            Text(
              'MyMoney gives you the tools to manage your money,\nnot the other way around.',
              textAlign: TextAlign.center,
              style: CustomTextStyles.h3Text,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 240,
              width: 230,
              decoration: BoxDecoration(
                  color: ColorTheme.seconderyColor,
                  borderRadius: const BorderRadius.all(Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/images/bonbon-savings.png',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../theme/color_theme.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About',
              style: CustomTextStyles.titleText.copyWith(color: Colors.white)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          elevation: 0,
          backgroundColor: ColorTheme.primaryColor,
        ),
        body: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color: ColorTheme.primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(40))),
            ),
            Expanded(
              child: Center(
                  child: Container(
                      height: 180,
                      width: 300,
                      decoration: BoxDecoration(
                          color: ColorTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Devoloped by brocamp.\nSupported by abi shaikh.\nContact us.\nwww.brocamp.com",
                          style: CustomTextStyles.titleText
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ))),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../theme/color_theme.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feedback',
              style: CustomTextStyles.titleText.copyWith(color: Colors.white)),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'write your feedback...'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: 'Enter your Email...!'),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'SUMIT',
                  style: CustomTextStyles.h2Text.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}

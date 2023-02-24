import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../theme/color_theme.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedbackPage> {
  TextEditingController emailController = TextEditingController();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    color: ColorTheme.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(40))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: emailController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: 'write your feedback...'),
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
                  onPressed: () {
                    email(emailController.text, context);
                    emailController.clear();
                  },
                  child: Text(
                    'SUBMIT',
                    style:
                        CustomTextStyles.h2Text.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> email(String text, context) async {
    final Email email = Email(
      body: text,
      subject: 'Feedback',
      recipients: ['shibiliavm@gmail.com'],
      cc: ['nil'],
      bcc: ['nil'],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}

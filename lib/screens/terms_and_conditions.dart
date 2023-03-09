import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../theme/color_theme.dart';

class TandC extends StatelessWidget {
  const TandC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions',
            style: CustomTextStyles.h2Text.copyWith(color: Colors.white)),
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
        child: Column(children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
                color: ColorTheme.primaryColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(40))),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '''
          Thank you for choosing to use our Transaction Manager App (the "App"). By using the App, you agree to be bound by these terms and conditions (the "Terms"). If you do not agree to these Terms, please do not use the App.
                
          App Description

          The App is a tool that allows you to manage your transactions and keep track of your expenses. The App is free to use and does not require any registration.
                
          Use of the App

          You may use the App for personal or commercial purposes, subject to these Terms. You agree not to use the App for any illegal or unauthorized purposes. You also agree not to modify, distribute, transmit, display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any information, software, products, or services obtained from the App.
                
          Intellectual Property

          The App and all of its content, including but not limited to text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, are the property of the App's owner or its licensors and are protected by United States and international copyright laws. You may not use any of this content without the express written permission of the App's owner.
                
          Limitation of Liability

          The App's owner is not liable for any damages arising from your use of the App, including but not limited to direct, indirect, incidental, punitive, and consequential damages. The App's owner is not responsible for any loss of data, revenue, or profits arising from your use of the App. The App's owner is not responsible for any errors or omissions in the App's content.
                
          Privacy

          We respect your privacy and are committed to protecting your personal information. Please review our Privacy Policy for more information about how we collect, use, and protect your information.
                
          Changes to the Terms and Conditions

          The App's owner reserves the right to modify these Terms and Conditions at any time without prior notice. Your continued use of the App after any such modification constitutes your acceptance of the modified Terms and Conditions.
                
          Termination

          The App's owner reserves the right to terminate your access to the App at any time, with or without cause or notice.
                
          Governing Law

          These Terms and Conditions are governed by and construed in accordance with the laws of the State of [Insert State] without giving effect to any principles of conflicts of law.
                
                If you have any questions about these Terms, please contact us at [Insert Contact Information].
                ''',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

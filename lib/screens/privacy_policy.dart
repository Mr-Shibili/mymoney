import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mymoney/screens/widgets/global_widgets.dart';

import '../theme/color_theme.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',
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
              '''Thank you for choosing to use our Transaction Manager App (the "App"). We are committed to protecting your privacy and want to ensure that you understand how we collect, use, and protect your personal information. This Privacy Policy explains our practices related to the App. By using the App, you agree to be bound by this Privacy Policy.

 - Information We Collect
The App does not require any registration, and we do not collect any personal information from you. We do not collect any information that can identify you or any information about your transactions.

 - Use of Your Information
Since we do not collect any personal information from you, we do not use your information for any purpose.

Disclosure of Your Information
Since we do not collect any personal information from you, we do not disclose your information to any third parties.

 - Security of Your Information
We take reasonable measures to protect your information from unauthorized access, use, disclosure, or loss. However, no data transmission over the Internet or any wireless network can be guaranteed to be 100% secure. We cannot ensure or warrant the security of any information you transmit to us or store on the App, and you do so at your own risk.

 - Children's Privacy
The App is not intended for children under the age of 13. We do not knowingly collect personal information from children under the age of 13. If you are a parent or guardian and believe that your child under the age of 13 has provided personal information to us, please contact us immediately, and we will delete the information from our system.

 - Changes to Our Privacy Policy
We reserve the right to modify this Privacy Policy at any time without prior notice. If we make any material changes to this Privacy Policy, we will post a notice on the App. Your continued use of the App after any such modification constitutes your acceptance of the modified Privacy Policy.

 - Contact Us
If you have any questions about this Privacy Policy or the App, please contact us at [9895713713].

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

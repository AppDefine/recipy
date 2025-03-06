import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy & Terms of Use'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy & Terms of Use',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Effective Date: [Insert Date]',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Text(
              'Recipy ("we," "our," or "us") is committed to protecting your privacy. When you use our recipe app ("the App"), we collect certain information, such as your name, email address, and password when you sign up or create an account. We also gather data about how you use the App, such as the recipes you view and the categories you browse, as well as information about the device you use to access the App.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We use this information to improve the App’s functionality, personalize your experience by suggesting recipes, and send you updates or promotional materials if you opt in.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We do not sell your information but may share it with service providers or legal authorities when required by law.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'You have the option to update or delete your account information through the App settings and can opt out of promotional emails by clicking "unsubscribe" in the email.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We use industry-standard practices to protect your information, but complete security cannot be guaranteed. We may update this policy occasionally and will notify you of significant changes.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 32),
            Text(
              'By using Recipy ("the App"), you agree to the following:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'The App is intended for personal, non-commercial use, and you must be at least 13 years old to use it.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'You agree not to use the App for illegal activities, share offensive content, or interfere with its systems. The content within the App, such as recipes, images, and text, is owned by Recipy or its licensors and may not be used or distributed without permission.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'The App is provided "as is," without warranties of any kind. We do not guarantee the accuracy or reliability of the content.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'We are not liable for any damages or losses arising from your use of the App. Updates to these terms will be posted, and continued use of the App indicates your acceptance of the updated terms.',
              style: TextStyle(fontSize: 16),
            ),
            Divider(height: 32),
            Text(
              'If you have questions about our policies, contact us at [Insert Contact Email].',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

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
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Please read this privacy policy before accessing or using Recipy!',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.normal),
            ),
            SizedBox(height: 16),
            buildSectionTitle('I. Introduction'),
            buildSectionContent(
                'Recipy is a mobile application designed to provide users with a comprehensive collection of recipes, meal planning tools, and the ability to save favorites. The app offers recipes for breakfast, lunch, and dinner to inspire users to create delicious meals.'),
            buildSectionTitle('II. What Data We Collect'),
            buildSectionContent(
                'We collect personal information such as your name, email address, and preferences to enhance your experience. Registration is required for features like saving favorites, creating meal plans, and accessing personalized recommendations. Non-personal data, such as device information and app usage statistics, is also collected to improve functionality.'),
            buildSectionTitle('III. How We Use Information'),
            buildSectionContent(
                'The information collected is used to enhance app features, provide personalized recipe suggestions, and ensure security. Data helps us operate, improve, and customize Recipy while maintaining a secure environment for users.'),
            buildSectionTitle('IV. Information Security and Storage'),
            buildSectionContent(
                'We implement secure data handling practices and retain personal information only as long as necessary. Users can request the deletion of their data by contacting our support team at support@recipyapp.com.'),
            buildSectionTitle('V. Changes to This Policy'),
            buildSectionContent(
                'This policy may be updated periodically. Significant changes will be communicated via email or through prominent notices within Recipy.'),
            buildSectionTitle('VI. Application of This Policy'),
            buildSectionContent(
                'This policy applies to the Recipy mobile application and related services. It does not cover third-party services or external links accessed through the app.'),
            SizedBox(height: 16),
            Divider(height: 32),
            Text(
              'If you have any questions or concerns, contact us at support@recipyapp.com.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16),
    );
  }
}

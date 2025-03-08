import 'package:flutter/material.dart';
import 'package:recipy/utils/constants.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('⭐ Introduction'),
            buildSectionContent(
                'Recipy is an innovative mobile application that empowers users to explore a vast collection of recipes, streamline meal planning, and curate personalized favorites. Whether for breakfast, lunch, or dinner, Recipy inspires culinary creativity.'),
            buildSectionTitle('🔍 What Data We Collect'),
            buildSectionContent(
                'We gather essential personal information, including your name, email address, and preferences, to provide a tailored experience. Registration unlocks features like saving favorites, crafting meal plans, and accessing customized recommendations. Non-personal data such as device details and app usage statistics are also collected to enhance functionality.'),
            buildSectionTitle('💡 How We Use Your Information'),
            buildSectionContent(
                'Your data is utilized to optimize app features, deliver personalized recipe suggestions, and maintain a secure environment. This helps us continuously improve and adapt Recipy to better meet your needs.'),
            buildSectionTitle('🔒 Information Security and Storage'),
            buildSectionContent(
                'We employ robust security measures to safeguard your data and retain personal information only for as long as necessary. You can request data deletion at any time by reaching out to support@recipyapp.com.'),
            buildSectionTitle('🔄 Changes to This Policy'),
            buildSectionContent(
                'We may update this policy periodically to reflect changes in our practices. Significant updates will be communicated through email or prominent notices within the app.'),
            buildSectionTitle('🌐 Scope of This Policy'),
            buildSectionContent(
                'This privacy policy applies exclusively to the Recipy mobile application and associated services. It does not extend to third-party platforms or external links accessed through the app.'),
            Divider(height: 32, thickness: 1.0, color: kPrimaryColor),
            Text(
              'For any inquiries or concerns, please contact us at support@recipyapp.com.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Georgia',
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Georgia',
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 15,
        fontFamily: 'Georgia',
        color: Colors.grey[800],
        height: 1.6,
      ),
    );
  }
}

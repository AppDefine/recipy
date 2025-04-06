import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipy/core/constants/constants.dart';

class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  List<Map<String, String>> faqs = [
    {
      "question": "How do I save my favorite recipes?",
      "answer": "Tap the heart icon on any recipe to add it to your favorites."
    },
    {
      "question": "Can I customize meal plans?",
      "answer": "Meal plans cannot be fully customized, but you can choose from different options available in three categories: Breakfast, Lunch, and Dinner."
    },
    {
      "question": "What meal plan options are available?",
      "answer": "Recipy offers tailored meal plans for Breakfast, Lunch, and Dinner. Each category provides a variety of recipes to suit your preferences."
    },
    {
      "question": "How can I access premium features?",
      "answer": "To access premium features like meal plans and personalized recommendations, you can subscribe to our premium plan within the app."
    },
    {
      "question": "Is an internet connection required to use Recipy?",
      "answer": "Yes, an active internet connection is required to browse recipes and access meal plans. However, you can save recipes for offline access."
    },
    {
      "question": "Can I share recipes with others?",
      "answer": "Yes, you can share your favorite recipes with friends and family via social media or messaging apps directly from the app."
    },
    {
      "question": "How do I update my account details?",
      "answer": "Go to the Profile section in the app, where you can edit your name, email address, and other personal information."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Help & Support"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('💬 Need Assistance?'),
            buildSectionContent(
                'We are here to help! If you encounter any issues or have questions about using Recipy, please do not hesitate to reach out to us.'),
            buildSectionTitle('📧 Contact Us'),
            buildSectionContent(
                'For support inquiries, please email us at support@testrecipy.com. Our team is dedicated to responding promptly to your concerns.'),
            buildSectionTitle('❓ FAQs'),
            ...faqs.map((faq) => buildExpandableFaq(faq["question"]!, faq["answer"]!)).toList(),
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

  Widget buildExpandableFaq(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          title: Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Georgia',
              color: Colors.grey[900],
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Georgia',
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

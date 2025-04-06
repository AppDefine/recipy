import 'package:flutter/material.dart';
import 'package:recipy/core/constants/constants.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("About Us"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle('🍳 Welcome to Recipy'),
            buildSectionContent(
                'Recipy is your ultimate culinary companion, offering a diverse collection of recipes from around the globe. Whether you are a seasoned chef or a home cook, our platform is designed to inspire your meal creations and streamline your kitchen experience.'),
            buildSectionTitle('🌟 Our Mission'),
            buildSectionContent(
                'At Recipy, we aim to make cooking accessible, enjoyable, and stress-free. We are committed to providing high-quality recipes, premium meal plans, and personalized features that cater to every taste and dietary preference.'),
            buildSectionTitle('🤝 Join Our Community'),
            buildSectionContent(
                'Become part of a vibrant community of food enthusiasts. Save your favorite recipes, plan meals effortlessly, and explore a world of culinary delights tailored just for you.'),
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

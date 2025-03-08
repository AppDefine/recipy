import 'package:flutter/material.dart';
import 'package:recipy/utils/constants.dart';

class PremiumMealScreen extends StatefulWidget {
  final Map<String, dynamic> meal;

  const PremiumMealScreen({super.key, required this.meal});

  @override
  State<PremiumMealScreen> createState() => _PremiumMealScreenState();
}

class _PremiumMealScreenState extends State<PremiumMealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(widget.meal["name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Ingredients"),
              const SizedBox(height: 12),
              _buildIngredientsList(widget.meal["ingredients"]),
              const SizedBox(height: 20),
              _buildSectionTitle("Steps"),
              const SizedBox(height: 12),
              _buildStepsList(widget.meal["steps"]),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0,left: 3),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kBannerColor.withValues(alpha: 0.9), Colors.green.withValues(alpha: 0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildIngredientsList(List<String> ingredients) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kBannerColor.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, -2), // Top shadow
            ),
          ]
        ),
        child: Column(
          children: ingredients.map((ingredient) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryColor.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: kPrimaryColor,
                      size:25,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      ingredient,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStepsList(List<String> steps) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: kBannerColor.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, -2), // Top shadow
              ),
            ]
        ),
        child: Column(
          children: steps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryColor.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: Text(
                        "${entry.key + 1}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CookingScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  CookingScreen({super.key, required this.documentSnapshot});

  @override
  State<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  @override
  Widget build(BuildContext context) {
    final recipeName = widget.documentSnapshot['name'];
    final ingredients = List<String>.from(widget.documentSnapshot['ingredientName']);
    final ingredientAmounts = List<String>.from(widget.documentSnapshot['ingredientAmount']);
    final cookingSteps = List<String>.from(widget.documentSnapshot['cookingSteps']);
    final calories = widget.documentSnapshot['cal'];
    final cookingTime = widget.documentSnapshot['time'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          recipeName,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.notification, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ingredients Section
              const Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(
                          "${ingredients[index]} - ${ingredientAmounts[index]} gm",
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              // Cooking Time and Calories Section
              Row(
                children: [
                  const Icon(
                    Iconsax.flash_1,
                    size: 20,
                    color: Colors.grey,
                  ),
                  Text(
                    "$calories Cal",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    " · ",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),
                  ),
                  const Icon(
                    Iconsax.clock,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$cookingTime Min",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Cooking Steps Section
              const Text(
                "Cooking Steps",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cookingSteps.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            "${index + 1}.",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            cookingSteps[index],
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/meal_plan/premium_meal.dart';

class MealPlanExploreScreen extends StatefulWidget {
  final Map<String, dynamic> mealPlan;

  const MealPlanExploreScreen({
    super.key,
    required this.mealPlan,
  });

  @override
  State<MealPlanExploreScreen> createState() => _MealPlanExploreScreenState();
}

class _MealPlanExploreScreenState extends State<MealPlanExploreScreen> {

  Map<String, List<Map<String, dynamic>>> categorizedMeals = {};

  @override
  void initState() {
    super.initState();
    getMeals();
  }

  void getMeals() async {
    String mealPlanId = widget.mealPlan['docId']; // Assuming mealPlan contains docId
    CollectionReference mealsCollection = FirebaseFirestore.instance
        .collection('meal-plan') // Replace with your collection name
        .doc(mealPlanId) // Reference the specific mealPlan document
        .collection('premium-meals'); // Reference the sub-collection 'meals'

    try {
      QuerySnapshot mealsSnapshot = await mealsCollection.get();

      // Temporary map to categorize meals
      Map<String, List<Map<String, dynamic>>> tempMeals = {};

      // Loop through each meal document in the sub-collection
      mealsSnapshot.docs.forEach((doc) {
        var mealData = doc.data() as Map<String, dynamic>; // Get meal data as a Map
        String mealType = mealData['mealType']; // Extract mealType

        // Add the meal to the respective mealType category
        if (!tempMeals.containsKey(mealType)) {
          tempMeals[mealType] = [];
        }
        tempMeals[mealType]!.add(mealData);
      });

      // Update state with categorized meals
      setState(() {
        categorizedMeals = tempMeals;
      });
    } catch (e) {
      print("Error fetching meals: $e");
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(widget.mealPlan['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(widget.mealPlan["image"]),
            const SizedBox(height: 16),
            _buildDescription(widget.mealPlan["description"]),
            const SizedBox(height: 24),
            categorizedMeals.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _buildMealsSection(context, categorizedMeals),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) => const Icon(Icons.error),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }


  Widget _buildMealsSection(
      BuildContext context, Map<String, List<Map<String, dynamic>>> meals) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Text(
              "Meals",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          if (meals.containsKey("Breakfast"))
            _buildMealCategory(context, "Breakfast", meals["Breakfast"]!),
          const SizedBox(height: 16),
          if (meals.containsKey("Lunch"))
            _buildMealCategory(context, "Lunch", meals["Lunch"]!),
          const SizedBox(height: 16),
          if (meals.containsKey("Dinner"))
            _buildMealCategory(context, "Dinner", meals["Dinner"]!),
        ],
      ),
    );
  }

  Widget _buildMealCategory(
      BuildContext context, String title, List<Map<String, dynamic>> mealOptions) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          children: mealOptions
              .map((meal) => _buildMealTile(context, meal))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildMealTile(BuildContext context, Map<String, dynamic> meal) {
    return ListTile(
      title: Text(
        meal["name"],
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Colors.teal),
      onTap: () {
        print("-------------------- ${meal.toString()}");
        Get.to(() => PremiumMealScreen(meal: meal));
      },
    );
  }
}

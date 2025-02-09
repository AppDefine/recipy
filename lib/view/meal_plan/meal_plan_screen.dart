import 'package:flutter/material.dart';
import 'package:recipy/utils/constants.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mealPlans = [
      {
        'title': 'Diet Meal Plan',
        'description': 'Stay healthy with balanced, nutrient-rich meals designed for your daily needs.',
        'price': '\$19.99',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_pdDITl-_on_oQizgPc2_R_CwL0NhQ6eccQ&s',
        'duration': '4 Weeks',
        'meals': '28 Meals',
      },
      {
        'title': 'Weight Loss Meal Plan',
        'description': 'Enjoy tasty, low-calorie meals tailored to help you lose weight effectively.',
        'price': '\$29.99',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtsAUjyO0xORfUnvJ9X6sWuJRpN7QFADrpew&s',
        'duration': '6 Weeks',
        'meals': '42 Meals',
      },
      {
        'title': 'Weight Gain Meal Plan',
        'description': 'Fuel your body with high-protein meals that promote muscle growth and strength.',
        'price': '\$24.99',
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNyLAdFsIziWURqD2CY0_yqoo62Ew5TS2HVA&s',
        'duration': '8 Weeks',
        'meals': '56 Meals',
      },
    ];


    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Align(alignment:Alignment.center,child: const Text('Meal Plans'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mealPlans.length,
          itemBuilder: (context, index) {
            final mealPlan = mealPlans[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(mealPlan['image']!),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mealPlan['title']!,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    mealPlan['duration']!,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    mealPlan['meals']!,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle buy action
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Purchased: ${mealPlan['title']}',
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.shopping_cart, size: 16.0),
                                        SizedBox(width: 6.0),
                                        Text('Buy Now'),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    mealPlan['price']!,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      mealPlan['description']!,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/meal_plan/premium_meal.dart';

class MealPlanExploreScreen extends StatelessWidget {
  final String mealPlanType;

  const MealPlanExploreScreen({
    super.key,
    required this.mealPlanType,
  });

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> mealPlanDetails = {
      "Diet Meal Plan": {
        "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_pdDITl-_on_oQizgPc2_R_CwL0NhQ6eccQ&s",
        "description":
        "A balanced diet plan to maintain overall health and well-being.",
        "meals": {
          "Breakfast": [
            {
              "name": "Oats with fruits and nuts",
              "ingredients": [
                "1 cup oats",
                "1/2 cup milk or plant-based milk",
                "1/4 cup fruits (banana, berries, etc.)",
                "2 tbsp nuts (almonds, walnuts, etc.)"
              ],
              "steps": [
                "Boil the oats in milk until soft.",
                "Add fruits and nuts on top.",
                "Serve warm."
              ]
            },
            {
              "name": "Greek yogurt with granola",
              "ingredients": [
                "1 cup Greek yogurt or plant-based yogurt",
                "1/4 cup granola",
                "1 tbsp honey or maple syrup",
                "1/4 cup fresh fruits (strawberries, blueberries, etc.)"
              ],
              "steps": [
                "Pour Greek yogurt into a bowl.",
                "Top with granola, honey, and fresh fruits.",
                "Serve immediately."
              ]
            },
            {
              "name": "Avocado toast",
              "ingredients": [
                "1 slice whole-grain bread",
                "1/2 avocado",
                "1 pinch salt",
                "1 pinch pepper",
                "Optional: cherry tomatoes or chili flakes"
              ],
              "steps": [
                "Toast the bread until golden brown.",
                "Mash the avocado and spread it on the toast.",
                "Sprinkle with salt, pepper, and optional toppings."
              ]
            }
          ],
          "Lunch": [
            {
              "name": "Grilled paneer salad",
              "ingredients": [
                "100g paneer (or tofu for vegan)",
                "1 cup mixed greens",
                "1/4 cup cherry tomatoes",
                "1 tbsp olive oil",
                "1 tbsp lemon juice"
              ],
              "steps": [
                "Grill the paneer or tofu until golden brown.",
                "Mix greens, tomatoes, olive oil, and lemon juice in a bowl.",
                "Add grilled paneer on top and serve."
              ]
            },
            {
              "name": "Vegetable stir-fry with quinoa",
              "ingredients": [
                "1 cup cooked quinoa",
                "1 cup mixed vegetables (bell peppers, broccoli, carrots, etc.)",
                "1 tbsp soy sauce",
                "1 tbsp olive oil",
                "1 clove garlic (minced)"
              ],
              "steps": [
                "Heat olive oil in a pan and sauté garlic.",
                "Add mixed vegetables and stir-fry until tender.",
                "Add soy sauce and cooked quinoa, mix well, and serve."
              ]
            },
            {
              "name": "Chickpea curry with rice",
              "ingredients": [
                "1 cup cooked rice",
                "1 cup cooked chickpeas",
                "1/2 cup coconut milk",
                "1/2 cup diced tomatoes",
                "1 tsp curry powder"
              ],
              "steps": [
                "In a pan, mix chickpeas, coconut milk, tomatoes, and curry powder.",
                "Simmer for 10-15 minutes until thickened.",
                "Serve hot with rice."
              ]
            }
          ],
          "Dinner": [
            {
              "name": "Vegetable soup with bread",
              "ingredients": [
                "2 cups mixed vegetables (carrots, celery, potatoes, etc.)",
                "4 cups vegetable stock",
                "1 tbsp olive oil",
                "1 clove garlic (minced)",
                "Optional: whole-grain bread for serving"
              ],
              "steps": [
                "Heat olive oil in a pot and sauté garlic.",
                "Add vegetables and vegetable stock, and bring to a boil.",
                "Simmer until vegetables are tender and serve with bread."
              ]
            },
            {
              "name": "Spinach and mushroom pasta",
              "ingredients": [
                "1 cup whole-grain pasta",
                "1 cup spinach",
                "1/2 cup mushrooms (sliced)",
                "1/2 cup cream or plant-based cream",
                "1 clove garlic (minced)"
              ],
              "steps": [
                "Cook pasta according to package instructions.",
                "Sauté garlic, spinach, and mushrooms in a pan.",
                "Add cream and cooked pasta, mix well, and serve."
              ]
            },
            {
              "name": "Stuffed bell peppers",
              "ingredients": [
                "2 bell peppers",
                "1 cup cooked quinoa or rice",
                "1/2 cup mixed vegetables",
                "1/4 cup grated cheese (optional)",
                "1 tsp olive oil"
              ],
              "steps": [
                "Cut the tops off the bell peppers and remove seeds.",
                "Mix quinoa or rice with vegetables and stuff the mixture into the peppers.",
                "Drizzle with olive oil, top with cheese if desired, and bake at 180°C (350°F) for 20-25 minutes."
              ]
            }
          ]
        }
      },
      "Weight Gain Meal Plan": {
        "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_pdDITl-_on_oQizgPc2_R_CwL0NhQ6eccQ&s",
        "description":
        "A meal plan designed to promote healthy weight gain with nutrient-dense foods.",
        "meals": {
          "Breakfast": [
            {
              "name": "Oats with fruits and nuts",
              "ingredients": [
                "1 cup oats",
                "1/2 cup milk or plant-based milk",
                "1/4 cup fruits (banana, berries, etc.)",
                "2 tbsp nuts (almonds, walnuts, etc.)"
              ],
              "steps": [
                "Boil the oats in milk until soft.",
                "Add fruits and nuts on top.",
                "Serve warm."
              ]
            },
            {
              "name": "Greek yogurt with granola",
              "ingredients": [
                "1 cup Greek yogurt or plant-based yogurt",
                "1/4 cup granola",
                "1 tbsp honey or maple syrup",
                "1/4 cup fresh fruits (strawberries, blueberries, etc.)"
              ],
              "steps": [
                "Pour Greek yogurt into a bowl.",
                "Top with granola, honey, and fresh fruits.",
                "Serve immediately."
              ]
            },
            {
              "name": "Avocado toast",
              "ingredients": [
                "1 slice whole-grain bread",
                "1/2 avocado",
                "1 pinch salt",
                "1 pinch pepper",
                "Optional: cherry tomatoes or chili flakes"
              ],
              "steps": [
                "Toast the bread until golden brown.",
                "Mash the avocado and spread it on the toast.",
                "Sprinkle with salt, pepper, and optional toppings."
              ]
            }
          ],
          "Lunch": [
            {
              "name": "Grilled paneer salad",
              "ingredients": [
                "100g paneer (or tofu for vegan)",
                "1 cup mixed greens",
                "1/4 cup cherry tomatoes",
                "1 tbsp olive oil",
                "1 tbsp lemon juice"
              ],
              "steps": [
                "Grill the paneer or tofu until golden brown.",
                "Mix greens, tomatoes, olive oil, and lemon juice in a bowl.",
                "Add grilled paneer on top and serve."
              ]
            },
            {
              "name": "Vegetable stir-fry with quinoa",
              "ingredients": [
                "1 cup cooked quinoa",
                "1 cup mixed vegetables (bell peppers, broccoli, carrots, etc.)",
                "1 tbsp soy sauce",
                "1 tbsp olive oil",
                "1 clove garlic (minced)"
              ],
              "steps": [
                "Heat olive oil in a pan and sauté garlic.",
                "Add mixed vegetables and stir-fry until tender.",
                "Add soy sauce and cooked quinoa, mix well, and serve."
              ]
            },
            {
              "name": "Chickpea curry with rice",
              "ingredients": [
                "1 cup cooked rice",
                "1 cup cooked chickpeas",
                "1/2 cup coconut milk",
                "1/2 cup diced tomatoes",
                "1 tsp curry powder"
              ],
              "steps": [
                "In a pan, mix chickpeas, coconut milk, tomatoes, and curry powder.",
                "Simmer for 10-15 minutes until thickened.",
                "Serve hot with rice."
              ]
            }
          ],
          "Dinner": [
            {
              "name": "Vegetable soup with bread",
              "ingredients": [
                "2 cups mixed vegetables (carrots, celery, potatoes, etc.)",
                "4 cups vegetable stock",
                "1 tbsp olive oil",
                "1 clove garlic (minced)",
                "Optional: whole-grain bread for serving"
              ],
              "steps": [
                "Heat olive oil in a pot and sauté garlic.",
                "Add vegetables and vegetable stock, and bring to a boil.",
                "Simmer until vegetables are tender and serve with bread."
              ]
            },
            {
              "name": "Spinach and mushroom pasta",
              "ingredients": [
                "1 cup whole-grain pasta",
                "1 cup spinach",
                "1/2 cup mushrooms (sliced)",
                "1/2 cup cream or plant-based cream",
                "1 clove garlic (minced)"
              ],
              "steps": [
                "Cook pasta according to package instructions.",
                "Sauté garlic, spinach, and mushrooms in a pan.",
                "Add cream and cooked pasta, mix well, and serve."
              ]
            },
            {
              "name": "Stuffed bell peppers",
              "ingredients": [
                "2 bell peppers",
                "1 cup cooked quinoa or rice",
                "1/2 cup mixed vegetables",
                "1/4 cup grated cheese (optional)",
                "1 tsp olive oil"
              ],
              "steps": [
                "Cut the tops off the bell peppers and remove seeds.",
                "Mix quinoa or rice with vegetables and stuff the mixture into the peppers.",
                "Drizzle with olive oil, top with cheese if desired, and bake at 180°C (350°F) for 20-25 minutes."
              ]
            }
          ]
        }
      },
      "Weight Loss Meal Plan": {
        "image":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_pdDITl-_on_oQizgPc2_R_CwL0NhQ6eccQ&s",
        "description": "A meal plan designed to help achieve weight loss goals with balanced and calorie-conscious meals.",
        "meals": {
          "Breakfast": [
            {
              "name": "Oats with fruits and nuts",
              "ingredients": [
                "1 cup oats",
                "1/2 cup milk or plant-based milk",
                "1/4 cup fruits (banana, berries, etc.)",
                "2 tbsp nuts (almonds, walnuts, etc.)"
              ],
              "steps": [
                "Boil the oats in milk until soft.",
                "Add fruits and nuts on top.",
                "Serve warm."
              ]
            },
            {
              "name": "Greek yogurt with granola",
              "ingredients": [
                "1 cup Greek yogurt or plant-based yogurt",
                "1/4 cup granola",
                "1 tbsp honey or maple syrup",
                "1/4 cup fresh fruits (strawberries, blueberries, etc.)"
              ],
              "steps": [
                "Pour Greek yogurt into a bowl.",
                "Top with granola, honey, and fresh fruits.",
                "Serve immediately."
              ]
            },
            {
              "name": "Avocado toast",
              "ingredients": [
                "1 slice whole-grain bread",
                "1/2 avocado",
                "1 pinch salt",
                "1 pinch pepper",
                "Optional: cherry tomatoes or chili flakes"
              ],
              "steps": [
                "Toast the bread until golden brown.",
                "Mash the avocado and spread it on the toast.",
                "Sprinkle with salt, pepper, and optional toppings."
              ]
            }
          ],
          "Lunch": [
            {
              "name": "Grilled vegetable wrap",
              "ingredients": [
                "1 whole-grain wrap",
                "1/2 cup grilled vegetables (zucchini, bell peppers, etc.)",
                "1/4 cup hummus",
                "1 tbsp feta cheese (optional)"
              ],
              "steps": [
                "Spread hummus over the wrap.",
                "Add grilled vegetables and feta cheese.",
                "Roll the wrap tightly and serve."
              ]
            },
            {
              "name": "Quinoa salad",
              "ingredients": [
                "1 cup cooked quinoa",
                "1/2 cup chopped vegetables (cucumber, cherry tomatoes, etc.)",
                "1 tbsp olive oil",
                "1 tbsp lemon juice",
                "1 tbsp chopped parsley"
              ],
              "steps": [
                "Mix quinoa and chopped vegetables in a bowl.",
                "Drizzle with olive oil and lemon juice.",
                "Garnish with parsley and serve."
              ]
            },
            {
              "name": "Lentil soup with side salad",
              "ingredients": [
                "1 cup cooked lentils",
                "2 cups vegetable stock",
                "1/4 cup diced carrots and celery",
                "1 clove garlic (minced)"
              ],
              "steps": [
                "Sauté garlic, carrots, and celery in a pot.",
                "Add lentils and vegetable stock, simmer until tender.",
                "Serve hot with a small side salad."
              ]
            }
          ],
          "Dinner": [
            {
              "name": "Vegetable stir-fry with tofu",
              "ingredients": [
                "1 cup mixed vegetables (broccoli, carrots, bell peppers, etc.)",
                "100g tofu (cubed)",
                "1 tbsp soy sauce",
                "1 tsp sesame oil"
              ],
              "steps": [
                "Heat sesame oil in a pan and stir-fry tofu until golden.",
                "Add vegetables and soy sauce, cook until tender.",
                "Serve immediately."
              ]
            },
            {
              "name": "Stuffed zucchini boats",
              "ingredients": [
                "2 zucchini (halved and scooped)",
                "1/2 cup cooked quinoa",
                "1/4 cup tomato sauce",
                "1 tbsp grated cheese (optional)"
              ],
              "steps": [
                "Mix quinoa with tomato sauce and fill zucchini halves.",
                "Top with grated cheese if desired.",
                "Bake at 180°C (350°F) for 20 minutes."
              ]
            },
            {
              "name": "Cauliflower fried rice",
              "ingredients": [
                "1 cup cauliflower rice",
                "1/4 cup peas and carrots",
                "1 tbsp soy sauce",
                "1 tsp olive oil"
              ],
              "steps": [
                "Heat olive oil in a pan and sauté peas and carrots.",
                "Add cauliflower rice and soy sauce, stir-fry for 5 minutes.",
                "Serve hot."
              ]
            }
          ]
        }
      }
    };

    final mealPlan = mealPlanDetails[mealPlanType];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(mealPlanType),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(mealPlan["image"]),
            const SizedBox(height: 16),
            _buildDescription(mealPlan["description"]),
            const SizedBox(height: 24),
            _buildMealsSection(context, mealPlan["meals"]),
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

  Widget _buildMealsSection(BuildContext context, Map<String, dynamic> meals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Meals",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildMealCategory(context, "Breakfast", meals["Breakfast"]),
        const SizedBox(height: 16),
        _buildMealCategory(context, "Lunch", meals["Lunch"]),
        const SizedBox(height: 16),
        _buildMealCategory(context, "Dinner", meals["Dinner"]),
      ],
    );
  }

  Widget _buildMealCategory(BuildContext context, String title, List<Map<String, dynamic>> mealOptions) {
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
          children: mealOptions.map((meal) => _buildMealTile(context, meal)).toList(),
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
        Get.to(()=>PremiumMealScreen(meal: meal));
      },
    );
  }



}

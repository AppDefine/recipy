import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipy/controller/meal_plan_controller.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/meal_plan/meal_plan_explore_screen.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final MealPlanController controller = Get.find();
  List<String> listOfDocIdMealPlan = [];

  @override
  void initState() {
    super.initState();
    getDocIdMealPlan();
  }

  getDocIdMealPlan() async {
    controller.showLoading();
    final pref = Constants.securePreferences();
    var uid = await pref.read(key: Constants.uid);
    if (uid != null) {
      listOfDocIdMealPlan = await controller.getDocIdMealPlan(uid);
      controller.hideLoading();
      print("--------------- ${listOfDocIdMealPlan}");
    } else {
      print('UID is null');
      listOfDocIdMealPlan = [];
      controller.hideLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Align(
          alignment: Alignment.center,
          child: const Text('Meal Plans'),
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('meal-plan') // Adjusted collection name
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No meal plans available.'),
              );
            }

            final mealPlans = snapshot.data!.docs;

            return ListView.builder(
              itemCount: mealPlans.length,
              itemBuilder: (context, index) {
                final mealPlan =
                mealPlans[index].data() as Map<String, dynamic>;
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
                                  image: NetworkImage(mealPlan['image']),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mealPlan['title'],
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        mealPlan['duration'],
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        mealPlan['meals'],
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      listOfDocIdMealPlan
                                          .contains(mealPlan['docId'])
                                          ? FilledButton.icon(
                                        onPressed: () {
                                          Get.to(() => MealPlanExploreScreen(
                                            mealPlan: mealPlan, // Pass the meal plan title dynamically
                                          ));
                                        },
                                        icon: const Icon(
                                            Icons.restaurant,
                                            size: 16.0),
                                        label: const Text('Explore'),
                                        style: FilledButton.styleFrom(
                                          backgroundColor:
                                          kPrimaryColor, // Set custom background color
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(8.0),
                                          ),
                                        ),
                                      )
                                          : FilledButton.icon(
                                        onPressed: () async {
                                          String currency = "usd";
                                          bool paymentSuccess =
                                          await controller
                                              .makePayment(
                                            double.parse(
                                                mealPlan['price']),
                                            currency,
                                          );

                                          if (paymentSuccess) {
                                            CollectionReference
                                            users =
                                            FirebaseFirestore
                                                .instance
                                                .collection(
                                                'users');
                                            final pref = Constants
                                                .securePreferences();
                                            var uid =
                                            await pref.read(
                                                key: Constants
                                                    .uid);

                                            if(uid != null){
                                              await users
                                                  .doc(uid)
                                                  .update({
                                                'docIDMealPlan':
                                                FieldValue
                                                    .arrayUnion([mealPlan['docId']]),
                                              });
                                              getDocIdMealPlan();
                                            }
                                          } else {}
                                        },
                                        icon: const Icon(
                                            Icons.shopping_cart,
                                            size: 16.0),
                                        label: const Text('Buy Now'),
                                        style: FilledButton.styleFrom(
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(8.0),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$" + mealPlan['price'],
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
                          mealPlan['description'],
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
            );
          },
        ),
      )),
    );
  }
}

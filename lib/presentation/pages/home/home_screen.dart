import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/core/widget/banner.dart';
import 'package:recipy/core/widget/my_icon_button.dart';
import 'package:recipy/presentation/controller/item_controller.dart';
import 'package:recipy/presentation/pages/home/all_recipe.dart';
import 'package:recipy/presentation/pages/home/food_items_display.dart';
import 'package:recipy/presentation/pages/notification_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String category = "All";
  // for category
  final CollectionReference categoriesItems =
  FirebaseFirestore.instance.collection("recipy-category");
  // for all itesm display
  Query get fileteredRecipes =>
      FirebaseFirestore.instance.collection("recipy").where(
        'category',
        isEqualTo: category,
      );
  Query get allRecipes =>
      FirebaseFirestore.instance.collection("recipy");
  Query get selectedRecipes =>
      category == "All" ? allRecipes : fileteredRecipes;

  ItemController itemController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerParts(),
                  SizedBox(height: 20,),
                  const BannerToExplore(),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // for category
                  selectedCategory(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quick & Easy",
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 0.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Get.to(()=>AllRecipeScreen());
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(
                            color: kBannerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: selectedRecipes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> recipes =
                      snapshot.data?.docs ?? [];
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: recipes
                            .map((e) => FoodItemsDisplay(documentSnapshot: e))
                            .toList(),
                      ),
                    ),
                  );
                }
                // it means if snapshot has date then show the date otherwise show the progress bar
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      )),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> selectedCategory() {
    return StreamBuilder(
      stream: categoriesItems.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                streamSnapshot.data!.docs.length,
                    (index) => GestureDetector(
                  onTap: () {
                    itemController.loadFavorites();
                    print("------------"); // todo
                    setState(() {
                      category = streamSnapshot.data!.docs[index]['name'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                      category == streamSnapshot.data!.docs[index]['name']
                          ? kPrimaryColor
                          : Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      streamSnapshot.data!.docs[index]['name'],
                      style: TextStyle(
                        color:
                        category == streamSnapshot.data!.docs[index]['name']
                            ? Colors.white
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        // it means if snapshot has date then show the date otherwise show the progress bar
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Row headerParts() {
    return Row(
      children: [
        const Text(
          "What are you\ncooking today?",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        const Spacer(),
        MyIconButton(
          icon: Iconsax.notification,
          pressed: () {
            Get.to(() => NotificationListScreen());
          },
        ),
      ],
    );
  }
}

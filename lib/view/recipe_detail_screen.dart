import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipy/controller/controller/item_controller.dart';
import 'package:recipy/controller/controller/quantity_controller.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/cooking_screen.dart';
import 'package:recipy/widget/my_icon_button.dart';
import 'package:recipy/widget/quantity_increment_decrement.dart';

class RecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  const RecipeDetailScreen({super.key, required this.documentSnapshot});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {

  QuantityController quantityController = Get.find();
  ItemController itemController = Get.find();

  @override
  void initState() {
    // initialize base ingredient amounts in the provider
    print("------ ${widget.documentSnapshot['ingredientAmount']}");
    List<double> baseAmounts = widget.documentSnapshot['ingredientAmount']
        .map<double>((amount) => double.parse(amount.toString()))
        .toList();

    quantityController.setBaseIngredientAmounts(baseAmounts);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // final provider = FavoriteProvider.of(context);
    // final quantityProvider = Provider.of<QuantityProvider>(context);
    return Obx(() => Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: startCookingAndFavoriteButton(),
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // for image
                  Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          widget.documentSnapshot['image'],
                        ),
                      ),
                    ),
                  ),
                  // for back button

                  Positioned(
                    left: 0,
                    right: 0,
                    top: MediaQuery.of(context).size.width,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              // for drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.documentSnapshot['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.flash_1,
                          size: 20,
                          color: Colors.grey,
                        ),
                        Text(
                          "${widget.documentSnapshot['cal']} Cal",
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
                          "${widget.documentSnapshot['time']} Min",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // for rating
                    Row(
                      children: [
                        const Icon(
                          Iconsax.star1,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.documentSnapshot['rating'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("/5"),
                        const SizedBox(width: 5),
                        Text(
                          "${widget.documentSnapshot['reviews'.toString()]} Reviews",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ingredients",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "How many servings?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        QuantityIncrementDecrement(
                          currentNumber: quantityController.currentNumber,
                          onAdd: () => quantityController.increaseQuantity(),
                          onRemov: () => quantityController.decreaseQuantity(),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // list of ingredients
                    Column(
                      children: [
                        Row(
                          children: [
                            // ingredients images
                            Column(
                              children: widget
                                  .documentSnapshot['ingredientImage']
                                  .map<Widget>(
                                    (imageUrl) => Container(
                                  height: 60,
                                  width: 60,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        imageUrl,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                            const SizedBox(width: 20),
                            // ingredients name
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.documentSnapshot['ingredientName']
                                  .map<Widget>((ingredient) => SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    ingredient,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                            // ingredient amount
                            const Spacer(),
                            Column(
                              children: quantityController.updateIngredientAmounts
                                  .map<Widget>((amount) => SizedBox(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "${amount} gm",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 45,
          left: 10,
          right: 10,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: MyIconButton(
                  icon: Icons.arrow_back_ios_new,
                  pressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Spacer(),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: MyIconButton(
                  icon: Iconsax.notification,
                  pressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
      )
    ),
    );
  }

  FloatingActionButton startCookingAndFavoriteButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.transparent,
      elevation: 0,
      onPressed: () {},
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10), // Top margin
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, bottom: 10), // Left and bottom margin
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 13),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CookingScreen(
                          documentSnapshot: widget.documentSnapshot,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Start Cooking",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Circle background color
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    itemController.toggleFavorite(widget.documentSnapshot);
                  },
                  icon: Icon(
                    itemController.isExist(widget.documentSnapshot)
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color: itemController.isExist(widget.documentSnapshot)
                        ? Colors.red
                        : Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Bottom margin
        ],
      ),
    );
  }

}

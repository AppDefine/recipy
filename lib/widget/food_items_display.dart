import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipy/controller/controller/ItemController.dart';
import 'package:recipy/view/recipe_detail_screen.dart';

class FoodItemsDisplay extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;
  FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  State<FoodItemsDisplay> createState() => _FoodItemsDisplayState();
}

class _FoodItemsDisplayState extends State<FoodItemsDisplay> {

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  // List<String> _favoriteIds = [];

  ItemController itemController = Get.find();

  @override
  void initState() {
    itemController.loadFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailScreen(documentSnapshot: widget.documentSnapshot),
          ),
        );
        ///todo
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 230,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.documentSnapshot['image'], // image from firestore
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.documentSnapshot['name'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Iconsax.flash_1,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      "${widget.documentSnapshot['cal']} Cal",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                      size: 16,
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
                )
              ],
            ),
            // for favorite button
            // now let's whok on favorite button using provider
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    // provider.toggleFavorite(documentSnapshot);
                    itemController.toggleFavorite(widget.documentSnapshot);
                    // setState(() {
                    //
                    // });//todo
                  },
                  child: Icon(
                    itemController.isExist(widget.documentSnapshot)
                        ? Iconsax.heart5
                        : Iconsax.heart,
                    color: itemController.isExist(widget.documentSnapshot)
                        ? Colors.red
                        : Colors.black,
                    // Iconsax.heart, /// todo
                    size: 20,
                  ),
                ),
              ),
            ),
            // lets design a favorite screen
          ],
        ),
      ),
    ));
  }

  // // load favories from firestore (store favorite or not)
  // Future<void> loadFavorites() async {
  //   try {
  //     QuerySnapshot snapshot =
  //     await _firestore.collection("userFavorite").get();
  //     _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   setState(() {});
  // }
  //
  //
  //
  // void toggleFavorite(DocumentSnapshot product) async {
  //   String productId = product.id;
  //   if (_favoriteIds.contains(productId)) {
  //     _favoriteIds.remove(productId);
  //     await _removeFavorite(productId); // remove from favorite
  //   } else {
  //     _favoriteIds.add(productId);
  //     await _addFavorite(productId); // add to favorite
  //   }
  //   setState(() {});
  // }
  //
  // // Remove favorite from firestore
  // Future<void> _removeFavorite(String productId) async {
  //   try {
  //     await _firestore.collection("userFavorite").doc(productId).delete();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  //
  // // add favorites to firestore
  // Future<void> _addFavorite(String productId) async {
  //   try {
  //     await _firestore.collection("userFavorite").doc(productId).set({
  //       'isFavorite':
  //       true, // create the userFavorite collection and add item as favorites inf firestore
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  //
  // // chek if a product is favorited
  // bool isExist(DocumentSnapshot prouct) {
  //   return _favoriteIds.contains(prouct.id);
  // }
}

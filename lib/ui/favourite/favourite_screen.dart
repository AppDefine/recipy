import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipy/controller/item_controller.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/ui/recipe_detail_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  ItemController itemController = Get.find();

  Future<List<DocumentSnapshot>> fetchFavorites() async {
    // Fetch all favorites at once
    return await Future.wait(
      itemController.favoriteIds.map((favoriteId) {
        return FirebaseFirestore.instance.collection("recipy").doc(favoriteId).get();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {


    final favoriteItems = itemController.favoriteIds;
    return Obx(() => Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Align(alignment:Alignment.center,child: Text('Favorites')),
      ),
      body: favoriteItems.isEmpty
          ? const Center(
        child: Text(
          "No Favorites yet",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
          : FutureBuilder<List<DocumentSnapshot>>(
        future: fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor,), // One loader for all
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No favorites found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final favoriteData = snapshot.data!;
          return ListView.builder(
            itemCount: favoriteData.length,
            itemBuilder: (context, index) {
              var favoriteItem = favoriteData[index];
              if (favoriteItem.data() == null) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailScreen(documentSnapshot: favoriteItem),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Image
                        Container(
                          width: 100,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(favoriteItem['image']),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                favoriteItem['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(Iconsax.flash_1, size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${favoriteItem['cal']} Cal",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Text(" · ", style: TextStyle(color: Colors.grey)),
                                  const Icon(Iconsax.clock, size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${favoriteItem['time']} Min",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            itemController.toggleFavorite(favoriteItem);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipy/core/constants/constants.dart';
import 'package:recipy/presentation/pages/home/food_items_display.dart';

class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AllRecipeScreen> createState() => _AllRecipeListSnState();
}

class _AllRecipeListSnState extends State<AllRecipeScreen> {
  final CollectionReference selectedRecipes =
  FirebaseFirestore.instance.collection('recipy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text("Explore Recipe"),
      ),
      body: StreamBuilder(
        stream: selectedRecipes.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> recipes = snapshot.data?.docs ?? [];
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                  child: FoodItemsDisplay(documentSnapshot: recipes[index]),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

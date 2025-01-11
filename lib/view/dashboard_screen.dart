import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipy/utils/constants.dart';
import 'package:recipy/view/favourite_screen.dart';
import 'package:recipy/view/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int selectedIndex = 0;

  late final List<Widget> page;

 /* final List<Map<String, dynamic>> recipeDataList = [
    // Breakfast
    {
      "cal": "250",
      "category": "Breakfast",
      "image": "https://www.jessicagavin.com/wp-content/uploads/2020/07/avocado-toast-20-1200.jpg",
      "name": "Avocado Toast",
      "rating": "4.7",
      "reviews": 15,
      "time": 10,
      "ingredientAmount": ["1", "2", "1"],
      "ingredientImage": [
        "https://nutritionsource.hsph.harvard.edu/wp-content/uploads/2022/04/pexels-antonio-filigno-8538296-1024x657.jpg",
        "https://media.self.com/photos/5daa23395c250800081afa68/4:3/w_2560%2Cc_limit/sprouted-whole-grain-bread.jpg",
        "https://hips.hearstapps.com/hmg-prod/images/salt-types-1580315375.jpg"
      ],
      "ingredientName": ["Avocado", "Whole Grain Bread", "Salt"],
    },
    {
      "cal": "300",
      "category": "Breakfast",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtsAUjyO0xORfUnvJ9X6sWuJRpN7QFADrpew&s",
      "name": "Oatmeal with Fruits",
      "rating": "4.5",
      "reviews": 20,
      "time": 15,
      "ingredientAmount": ["1", "1", "1/2"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQCrrLWOKeH0zYFOrPlRiDWByAD0I7iZN76w&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTouQN7LHvvYfwD5POxlOdBQsBNgQErqDlb9w&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8RcgSSd0Rlfesh5-9ZVt6qyixOsotdSAFSQ&s"
      ],
      "ingredientName": ["Oats", "Banana", "Almond Milk"],
    },
    {
      "cal": "200",
      "category": "Breakfast",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJi3gy0mJcuDL7Ayk8DhAEcUGyWCOJQ0R3KQ&s",
      "name": "Greek Yogurt Parfait",
      "rating": "4.8",
      "reviews": 10,
      "time": 5,
      "ingredientAmount": ["1", "1/2", "1/2"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_YGppn1pip1VekrXXpBxjtf-Isw_MSRVYRQ&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoo0cKvZ4alp8WHk5UIvqAly84ywIVW08qbQ&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttdM561axG_b3-eDGIxAqOSZfSrMLek4KnQ&s"
      ],
      "ingredientName": ["Greek Yogurt", "Granola", "Mixed Berries"],
    },
    // Lunch
    {
      "cal": "450",
      "category": "Lunch",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM5m6nC_VLs-tXGdtpt5OWNMrYUtlkD3FUsw&s",
      "name": "Grilled Chicken Salad",
      "rating": "4.6",
      "reviews": 25,
      "time": 20,
      "ingredientAmount": ["1", "2", "1/2", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7SMp6CzhAUn0G-HoM8usjShFNFPU9VKpOLA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS3Gq41ZcxfGFCdAXnp-fgOsKnCwx-T2dHvg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0gdZa61vdoLl3n4NPnvk9li9DRu-EMc_VIg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm1MwNrWuEePEoQaeAW6AcTupbabHM99epoQ&s"
      ],
      "ingredientName": ["Chicken Breast", "Lettuce", "Tomato", "Olive Oil"],
    },
    {
      "cal": "400",
      "category": "Lunch",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhAnxagdui-yVTro1He-ioQW_BfnZYavo6Mw&s",
      "name": "Quinoa Veggie Bowl",
      "rating": "4.4",
      "reviews": 18,
      "time": 25,
      "ingredientAmount": ["1", "1", "1/2", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFknd5KpPaBGhrPHbfjx6zX4hv766ykIYYKQ&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHy9isokR1PsPlFnTvCAutpD7uTAJg89xlnA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc7V30BEkibc_BnCHVJjH21n_sPqLyhSqE-Q&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV0DhvV0NGNZbQP0v6nRr6dOmHB-kExiV88w&s"
      ],
      "ingredientName": ["Quinoa", "Broccoli", "Carrot", "Lemon"],
    },
    {
      "cal": "520",
      "category": "Lunch",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl7TmyscyrS4YfjqOU3WgOqK0xjjVR7On-MA&s",
      "name": "Grilled Salmon with Asparagus",
      "rating": "4.9",
      "reviews": 30,
      "time": 30,
      "ingredientAmount": ["1", "1", "2"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgGS9s3jgKolz64TsU_LKfjOzGsxE_MOS2tA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqJPrCjXCii2XOgLsoP7RnWYh_K141c0GJxg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm1MwNrWuEePEoQaeAW6AcTupbabHM99epoQ&s"
      ],
      "ingredientName": ["Salmon Fillet", "Asparagus", "Olive Oil"],
    },
    // Dinner
    {
      "cal": "600",
      "category": "Dinner",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNyLAdFsIziWURqD2CY0_yqoo62Ew5TS2HVA&s",
      "name": "Spaghetti Bolognese",
      "rating": "4.7",
      "reviews": 50,
      "time": 40,
      "ingredientAmount": ["200g", "100g", "1", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMKHOEZf4iE8Eg6ptxUwYSCVJr3RD5-wAqkQ&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJMrFLt-w04nmSFa1_hxnnfi8IZ_uxrlUaeg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0gdZa61vdoLl3n4NPnvk9li9DRu-EMc_VIg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0TIdZeEIlKvFVqvBSXKqnJn2UyJBLdVdXQ&s"
      ],
      "ingredientName": ["Spaghetti", "Ground Beef", "Tomato", "Onion"],
    },
    {
      "cal": "550",
      "category": "Dinner",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_pdDITl-_on_oQizgPc2_R_CwL0NhQ6eccQ&s",
      "name": "Vegetable Stir Fry",
      "rating": "4.3",
      "reviews": 22,
      "time": 30,
      "ingredientAmount": ["1", "1", "1/2", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsnMOjUqopk2Si1BwE9047SHtXfHnyKaXQTg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHy9isokR1PsPlFnTvCAutpD7uTAJg89xlnA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkro7iED-JyOmsFmyzSJ53YT14pysBmnAETQ&s%27",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTjJdS--h42krywtJvEO-tIRKiqQobOiCwwQ&s"
      ],
      "ingredientName": ["Bell Pepper", "Broccoli", "Soy Sauce", "Tofu"],
    },
    {
      "cal": "450",
      "category": "Dinner",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWyFJrV2vx2afHQD0C2GBcbfyhM9cWc5vwCw&s",
      "name": "Chicken Curry",
      "rating": "4.5",
      "reviews": 35,
      "time": 45,
      "ingredientAmount": ["300g", "1", "2", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzzznMNH4Es7GFou_iOCeySBbCnjPb6bBMg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc0TIdZeEIlKvFVqvBSXKqnJn2UyJBLdVdXQ&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi-6iuOEIUDQnHkaakIwlyWjW8APtcjTfj_w&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwqaz3AoGwwiB6ThY6fWT5gzu06SV59PNszg&s"
      ],
      "ingredientName": ["Chicken", "Onion", "Garlic", "Curry Powder"],
    },
    {
      "cal": "350",
      "category": "Dessert",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfOgc56DvWge12uRF81YE-X5ct_c3dCErzlg&s",
      "name": "Chocolate Cake",
      "rating": "4.8",
      "reviews": 40,
      "time": 60,
      "ingredientAmount": ["2 cups", "1 cup", "1/2 cup", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT56_Zk5HebloKD36kCSNDTs9k1we84o-7aIA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDrYPwkiopNH1sguZNlZUxk_rvXWKc0W7Eeg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrAMpOajqn45tWeRcHC91tVvwHl6Xzm6PS7g&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5BYI33492ty8lOOy8rTEwCcxgjujHRqGNyg&s"
      ],
      "ingredientName": ["Flour", "Sugar", "Cocoa Powder", "Egg"],
    },
    {
      "cal": "300",
      "category": "Dessert",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYv8WwFGk9bb8B0zyf2Gvd_3cGLEMT9LQQvw&s",
      "name": "Vanilla Ice Cream",
      "rating": "4.9",
      "reviews": 50,
      "time": 240,
      "ingredientAmount": ["2 cups", "1 cup", "1"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSloeHGlDwnYSPUsmiXFeY9X9UQ9xbDNY6pw&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDrYPwkiopNH1sguZNlZUxk_rvXWKc0W7Eeg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnRJdw2ONVb5oasYK_zgXiK1L5sKAWu_gELQ&s"
      ],
      "ingredientName": ["Milk", "Sugar", "Vanilla Extract"],
    },
    {
      "cal": "400",
      "category": "Dessert",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCOwLzikQJH7a1xys3MsBZAl9LZqmrvISc8Q&s",
      "name": "Fudge Brownie",
      "rating": "4.7",
      "reviews": 35,
      "time": 50,
      "ingredientAmount": ["1 cup", "1/2 cup", "1/4 cup", "2"],
      "ingredientImage": [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9IZ56UwMok1QX9DErQJJGzefw-0tEOYZyZA&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDrYPwkiopNH1sguZNlZUxk_rvXWKc0W7Eeg&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrAMpOajqn45tWeRcHC91tVvwHl6Xzm6PS7g&s",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5BYI33492ty8lOOy8rTEwCcxgjujHRqGNyg&s"
      ],
      "ingredientName": ["Butter", "Sugar", "Cocoa Powder", "Egg"],
    },
  ];


  Future<void> addMultipleRecipes() async {
    CollectionReference recipes = FirebaseFirestore.instance.collection('recipy');

    for (var recipeData in recipeDataList) {
      await recipes.add(recipeData);
    }
    print("All 10 recipe data added successfully!");
  }*/

  @override
  void initState() {
    page = [
      HomeScreen(),
      FavouriteScreen(),
      // navBarPage(Iconsax.heart5),
      navBarPage(Iconsax.calendar5),
      navBarPage(Iconsax.setting_21),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconSize: 28,
            currentIndex: selectedIndex,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.shifting,
            selectedLabelStyle: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
            onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),label: "Home"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),label: "Favourite"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),label: "Meal Plan"),
              BottomNavigationBarItem(icon: Icon(selectedIndex == 3 ? Iconsax.setting_21 : Iconsax.setting_2),label: "Setting"),
            ]
        ),
      body: page[selectedIndex],
    );
  }

  navBarPage(iconName){
    return Center(
      child: Icon(iconName,
      size: 100,
      color: kPrimaryColor,),
    );
  }
}

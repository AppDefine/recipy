
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ItemController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<String> _favoriteIds = <String>[].obs;


  RxList<String> get favoriteIds => _favoriteIds; // load favories from firestore (store favorite or not)

  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection("userFavorite").get();
      _favoriteIds.assignAll(snapshot.docs.map((doc) => doc.id).toList());
    } catch (e) {
      print(e.toString());
    }

  }



  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId); // remove from favorite
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId); // add to favorite
    }

  }

  // Remove favorite from firestore
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // add favorites to firestore
  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        'isFavorite':
        true, // create the userFavorite collection and add item as favorites inf firestore
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // chek if a product is favorited
  bool isExist(DocumentSnapshot prouct) {
    return _favoriteIds.contains(prouct.id);
  }
}
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:recipy/utils/constants.dart';

class MealPlanController extends GetxController {
  RxBool isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  Future<bool> makePayment(double amount, String currency) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(amount, currency);
      if (paymentIntentClientSecret == null) {
        return false;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Test Merchant",
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      showLoading();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

    final headers = {
      'Authorization': 'Bearer ${Constants.stripeSecretKey}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final body = {
      'amount': calculateAmountInCents(amount),
      'currency': currency,
      'description': 'Purchase of Product X (Export)',
      'shipping[name]': 'Test Name',
      'shipping[address][line1]': '123 Test Street',
      'shipping[address][city]': 'Test City',
      'shipping[address][state]': 'Test State',
      'shipping[address][postal_code]': '123456',
      'shipping[address][country]': 'IN',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Payment Intent created: ${response.body}');
        final jsonData = json.decode(response.body);
        return jsonData['client_secret'];
      } else {
        print('Failed to create Payment Intent: ${response.statusCode}');
        print(response.body);
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  String calculateAmountInCents(double amount) {
    int amountInCents = (amount * 100).toInt();
    return amountInCents.toString();
  }

  Future<List<String>> getDocIdMealPlan(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        print("============= $uid");
        print("============= ${userDoc.get('docIDMealPlan')}");
        return List<String>.from(userDoc.get('docIDMealPlan'));
      } else {
        print('User document does not exist');
        return [""];
      }
    } catch (e) {
      print('Error fetching docIdMealPlan: $e');
      return [""];
    }
  }
}
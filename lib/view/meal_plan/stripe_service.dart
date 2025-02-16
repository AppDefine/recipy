import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:recipy/utils/constants.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(amount, currency);
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Test Merchant"));
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _processPayment() async{
    try{
      await Stripe.instance.presentPaymentSheet();
    }catch(e){
      print(e);
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
      'shipping[address][country]': 'IN', // Use ISO country code
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
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String calculateAmountInCents(double amount) {
    int amountInCents = (amount * 100).toInt();
    return amountInCents.toString();
  }
}

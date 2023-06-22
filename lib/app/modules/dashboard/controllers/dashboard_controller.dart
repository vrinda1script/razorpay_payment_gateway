import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DashboardController extends GetxController {
  final razorpay = Razorpay();
  late TextEditingController amountTextController;
  late TextEditingController nameTextController;

  @override
  void onInit() {
    amountTextController = TextEditingController();
    nameTextController = TextEditingController();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void onClose() {
    amountTextController.dispose();
    nameTextController.dispose();
    razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Payment Successful", "Payment ID: ${response.paymentId}");
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet Selected", "${response.walletName}");
    // Do something when an external wallet was selected
  }

  void getPayment() async {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_8Zybetcdb6WXMt',
      'amount': amountTextController.text,
      'name': nameTextController.text,
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8077489911', 'email': 'mrayushgupta67@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print("error $e");
    }
    nameTextController.clear();
    amountTextController.clear();
  }
}

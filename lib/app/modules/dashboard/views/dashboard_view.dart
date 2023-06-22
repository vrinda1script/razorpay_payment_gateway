import 'package:add_payment/app/constants/app_colors.dart';
import 'package:add_payment/app/modules/widgets/custom_text_fields.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'RazorPay Payment Gateway',
            style: Get.textTheme.displayLarge!.copyWith(
              color: AppColors.appBlueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Pay with Razorpay',
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Name of User',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              UniversalTextField(
                  controller: controller.nameTextController,
                  keyboardType: TextInputType.name,
                  hintText: '',
                  validatorErrorText: '',
                  validationMessageOnBlankText: ''),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Amount',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              UniversalTextField(
                  controller: controller.amountTextController,
                  keyboardType: TextInputType.number,
                  hintText: '',
                  validatorErrorText: '',
                  validationMessageOnBlankText: ''),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.getPayment();
                      },
                      child: const Text("Pay with Razorpay")),
                ],
              ),
            ],
          ),
        ));
  }
}

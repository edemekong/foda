import 'package:flutter/material.dart';
import 'package:foda/screens/checkout/checkout_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PAYMENT METHOD",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Text(
          "Click one of your card.",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: AppTheme.grey,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(height: AppTheme.cardPadding),
        Row(
          children: List.generate(
            paymentMethods.length,
            (index) => Row(
              children: [
                Radio<bool>(
                  value: state.selectedPaymentMethod == paymentMethods[index],
                  groupValue: true,
                  onChanged: (v) {
                    state.setPayment(paymentMethods[index]);
                  },
                ),
                Text(
                  paymentMethods[index],
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

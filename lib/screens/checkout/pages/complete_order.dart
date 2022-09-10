import 'package:flutter/material.dart';
import 'package:foda/components/foda_button.dart';
import 'package:foda/screens/checkout/checkout_state.dart';
import 'package:foda/themes/app_theme.dart';
import 'package:provider/provider.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutState>();

    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, -0.95),
          child: Text(
            "Thank You Order",
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  color: AppTheme.orange,
                ),
          ),
        ),
        Positioned(
          bottom: AppTheme.cardPadding,
          left: AppTheme.cardPadding,
          right: AppTheme.cardPadding,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.purpleDark,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.currentUser.name,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: AppTheme.orange,
                          ),
                    ),
                    Text(
                      "Port Harcourt, Nigeria",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: AppTheme.grey,
                          ),
                    ),
                    const SizedBox(height: AppTheme.elementSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.call),
                                const SizedBox(width: AppTheme.elementSpacing * 0.5),
                                Text(
                                  "Personal +234XXXX 564",
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        color: AppTheme.grey,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.place),
                                const SizedBox(width: AppTheme.elementSpacing * 0.5),
                                Text(
                                  "14km - 5min",
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        color: AppTheme.grey,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "\$ ${state.totalOrderPrice}",
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                color: AppTheme.red,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.cardPadding),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.darkBlue,
                        ),
                        const SizedBox(width: AppTheme.elementSpacing),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Doe",
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              "Courier",
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: AppTheme.grey,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              FodaButton(
                title: "Complete",
                gradiant: const [
                  AppTheme.orange,
                  AppTheme.red,
                ],
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ],
    );
  }
}

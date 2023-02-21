import 'package:flutter/material.dart';

import 'package:mymoney/screens/widgets/global_widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../theme/color_theme.dart';

class Greenboard extends StatelessWidget {
  const Greenboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: 160,
          height: 200,
          decoration: BoxDecoration(
              color: ColorTheme.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: CustomTextStyles.h2Text
                        .copyWith(color: ColorTheme.whiteColor),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorTheme.seconderyColor,
                    size: 15,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Recent spend',
                style: CustomTextStyles.h3Text
                    .copyWith(color: ColorTheme.seconderyColor),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(),
                  Text('Star Bucks',
                      style: CustomTextStyles.h3Text
                          .copyWith(color: ColorTheme.whiteColor)),
                  Text('₹350',
                      style: CustomTextStyles.h3Text
                          .copyWith(color: ColorTheme.whiteColor))
                ],
              ),
              const SizedBox(height: 35),
              Text('Category',
                  style: CustomTextStyles.h3Text
                      .copyWith(color: ColorTheme.seconderyColor)),
              const SizedBox(height: 5),
              Text('Food & Drink',
                  style: CustomTextStyles.h3Text
                      .copyWith(color: ColorTheme.whiteColor))
            ],
          ),
        ),
        const SizedBox(width: 20),
        Container(
          width: 160,
          height: 200,
          decoration: BoxDecoration(
              color: ColorTheme.yellowColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Categories',
                          style: CustomTextStyles.h2Text
                              .copyWith(color: ColorTheme.whiteColor)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: ColorTheme.seconderyColor,
                      )
                    ],
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          minRadius: 14,
                        ),
                        Column(
                          children: [
                            const Text('Food'),
                            const SizedBox(height: 5),
                            LinearPercentIndicator(
                              width: 75.0,
                              lineHeight: 5.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(10),
                              progressColor:
                                  const Color.fromARGB(255, 253, 253, 252),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('₹500',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 12, fontFamily: 'Raleway')),
                            const SizedBox(height: 4),
                            Text('30%',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    color: ColorTheme.whiteColor))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          minRadius: 14,
                        ),
                        Column(
                          children: [
                            const Text('Food'),
                            const SizedBox(height: 6),
                            LinearPercentIndicator(
                              width: 75.0,
                              lineHeight: 5.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(10),
                              progressColor:
                                  const Color.fromARGB(255, 253, 253, 252),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('₹500',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 12, fontFamily: 'Raleway')),
                            const SizedBox(height: 4),
                            Text('30%',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    color: ColorTheme.whiteColor))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          minRadius: 14,
                        ),
                        Column(
                          children: [
                            const Text('Food'),
                            const SizedBox(height: 5),
                            LinearPercentIndicator(
                              width: 75.0,
                              lineHeight: 5.0,
                              percent: 0.5,
                              barRadius: const Radius.circular(10),
                              progressColor:
                                  const Color.fromARGB(255, 253, 253, 252),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('₹500',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 12, fontFamily: 'Raleway')),
                            const SizedBox(height: 4),
                            Text('30%',
                                style: CustomTextStyles.h3Text.copyWith(
                                    fontSize: 10,
                                    fontFamily: 'Raleway',
                                    color: ColorTheme.whiteColor))
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}

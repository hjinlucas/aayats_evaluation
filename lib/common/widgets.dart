import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_constant.dart';
import 'text_widgets.dart';

Widget beatsListingForm(
    {required String imageURL,
    required String heading,
    numOfLikes,
    tags,
    tune,
    bpm,
    price}) {
  return Container(
    width: 370.w,
    height: 90.h,
    margin: EdgeInsets.only(bottom: 6.h),
    decoration: BoxDecoration(
      gradient: linearGradientPTBwithOpacityAsBg,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 120.w,
          height: 90.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text16Bold(text: heading, textAlign: TextAlign.start),
              SizedBox(height: 6.h),
              text14Normal(
                text: "$numOfLikes likes",
                color: ColorConstant.brandTertiary,
              ),
              SizedBox(height: 2.h),
              text14NormalSecondary(text: tags),
              SizedBox(height: 2.h),
              text14NormalSecondary(text: "$tune $bpm bpm"),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Handle shopping cart button press
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            text12Normal(text: price, color: ColorConstant.brandPrimary)
          ],
        ),
        IconButton(
          onPressed: () {
            // Handle three-dot button press
          },
          icon: const Icon(Icons.more_vert),
        ),
      ],
    ),
  );
}

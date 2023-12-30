import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/constants/color_constant.dart';
import '../../common/widgets/text_widgets.dart';

class BeatsTile extends StatelessWidget {
  final Beats beats;
  const BeatsTile({super.key, required this.beats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        gradient: linearGradientPTBwithOpacityAsBg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(beats.imageUrl),
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
                text16Bold(text: beats.title, textAlign: TextAlign.start),
                SizedBox(height: 6.h),
                text14Normal(
                  text: "${beats.likes} likes",
                  color: ColorConstant.brandTertiary,
                ),
                SizedBox(height: 2.h),
                text14NormalSecondary(text: beats.artists[0]),
                // SizedBox(height: 2.h),
                text14NormalSecondary(text: "${beats.key} ${beats.bpm} bpm"),
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
              text12Normal(text: beats.price, color: ColorConstant.brandPrimary)
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
}

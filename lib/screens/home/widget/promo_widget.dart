import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class PromoWidget extends StatelessWidget {
  PromoWidget({super.key});
  final List<Map<String, dynamic>> coupons = [
    {
      "content": "Save 200k with orders from 2.000.000đ and up",
      "expDate": "05/04/2023"
    },
    {
      "content": "Save 500k with orders from 5.000.000đ and up",
      "expDate": "10/04/2023"
    },
    {
      "content": "Save 1000k with orders from 12.000.000đ and up",
      "expDate": "30/04/2023"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.h,
          vertical: 2.w,
        ),
        child: Row(
          children: List.generate(
              coupons.length,
              (index) => _buildCouponCard(
                    coupons[index]["content"],
                    coupons[index]["expDate"],
                  )),
        ),
      ),
    );
  }

  _buildCouponCard(String content, String expireDate) {
    return Container(
      constraints: BoxConstraints(maxWidth: 90.w),
      padding: EdgeInsets.all(1.8.h),
      margin: EdgeInsets.only(right: 2.h),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: primaryColor, width: 6),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: cardShadowColor.withOpacity(0.3),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            maxLines: 2,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
          const SizedBox(height: 5),
          Text("EXP: " + expireDate),
        ],
      ),
    );
  }
}

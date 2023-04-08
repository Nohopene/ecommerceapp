import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/screens/productdetails/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';
import '../../../models/product_model.dart';

class BuyNowWidget extends StatelessWidget {
  const BuyNowWidget({super.key, this.product});
  final Product? product;
  static const String id = 'test-screen';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2.h, 3.h, 2.h, 2.h),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      width: 120,
                      height: 120,
                      imageUrl: product!.imageUrl[1],
                      fit: BoxFit.contain,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            color: Colors.grey.shade200,
                            value: downloadProgress.progress),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2.h, 0, 0, 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product!.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => const Icon(
                              Icons.star_rounded,
                              color: primaryColor,
                            ),
                            direction: Axis.horizontal,
                            rating: product!.rating,
                            unratedColor: const Color(0xFF9E9E9E),
                            itemCount: 5,
                            itemSize: 12,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Row(
                            children: [
                              Text(
                                NumberFormat.simpleCurrency(
                                        decimalDigits: 0, locale: 'vi-VN')
                                    .format(product!.price),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 2.h,
                              ),
                              if (product!.percentOff! > 0)
                                Text(
                                  NumberFormat.simpleCurrency(
                                          decimalDigits: 0, locale: 'vi-VN')
                                      .format(product!.regularPrice),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'Quantity: ${product!.quantity}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          const Divider(
            color: Colors.grey,
            height: 10,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2.h, 2.h, 2.h, 2.h),
            child: Row(
              children: [
                const Text('Quantity'),
                const Spacer(),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(2)),
                  child: const Center(
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: null,
                      icon: Icon(
                        Icons.remove,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(2)),
                    child: const Center(child: Text('1'))),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(2)),
                  child: const IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            height: 10,
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2.h, 2.h, 2.h, 2.h),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(130, 15, 130, 15),
                child: Text('Buy now'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

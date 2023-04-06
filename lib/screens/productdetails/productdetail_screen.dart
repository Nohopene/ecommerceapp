import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/productdetails/widget/buynow_widget.dart';
import 'package:ecommerceapp/screens/productdetails/widget/elevated_button.dart';
import 'package:ecommerceapp/screens/productdetails/widget/product_description.dart';
import 'package:ecommerceapp/screens/productdetails/widget/product_image.dart';
import 'package:ecommerceapp/screens/productdetails/widget/product_infor.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:line_icons/line_icons.dart';
import 'package:sizer/sizer.dart';

class ProductDetail extends StatefulWidget {
  final String? productId;
  final Product? product;

  const ProductDetail({super.key, this.productId, this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  User? user = FirebaseAuth.instance.currentUser;

  final CartService _service = CartService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: Header(context),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(product: widget.product),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 3.h, 1.5.h, 5),
                  child: Text(
                    widget.product!.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 2, 1.5.h, 2),
                  child: Row(
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(
                                decimalDigits: 0, locale: 'vi-VN')
                            .format(widget.product!.price),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      if (widget.product!.percentOff! > 0)
                        Text(
                          NumberFormat.simpleCurrency(
                                  decimalDigits: 0, locale: 'vi-VN')
                              .format(widget.product!.regularPrice),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                _productDescription(context),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                _productSpecifications(context),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                _productReviews(),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
              ],
            ),
          ),
          bottomSheet: SizedBox(
            height: 70,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyElevatedButton(
                    title: 'Add to cart',
                    onPressed: () {
                      _service.checkCart(
                          product: widget.product, productId: widget.productId);
                    },
                    backgroundColor: discountColor,
                  ),
                  MyElevatedButton(
                    title: 'Buy now',
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (context) {
                            return BuyNowWidget(product: widget.product);
                          });
                    },
                    backgroundColor: primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _productReviews() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 0, 1.5.h, 0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Reviews',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'See all',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,
                        size: 16,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star_rounded,
                            color: primaryColor,
                          ),
                          direction: Axis.horizontal,
                          rating: widget.product!.rating,
                          unratedColor: const Color(0xFF9E9E9E),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.product!.rating}/5',
                          style: const TextStyle(
                              fontSize: 13, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _productSpecifications(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 0, 1.5.h, 0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return InformationWidget(
                      product: widget.product,
                    );
                  });
            },
            child: SizedBox(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specifications',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,
                        size: 16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _productDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 0, 1.5.h, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.product!.descriptions}',
            maxLines: 3,
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ProductDescription(
                      product: widget.product,
                    );
                  });
            },
            child: const Text(
              'See all',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

PreferredSize Header(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(7.h),
    child: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      flexibleSpace: Padding(
        padding: EdgeInsets.fromLTRB(1.5.h, 0, 1.5.h, 2.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 8.h,
                width: 8.w,
                padding: EdgeInsets.all(1.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF5F6F9),
                ),
                child: SvgPicture.asset('assets/icons/cancel.svg'),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(LineIcons.shoppingBag),
              onPressed: () {
                print('12312312313');
              },
            ),
          ],
        ),
      ),
    ),
  );
}

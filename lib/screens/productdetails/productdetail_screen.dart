import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/productdetails/widget/buynow_widget.dart';
import 'package:ecommerceapp/screens/productdetails/widget/description_widget.dart';
import 'package:ecommerceapp/screens/productdetails/widget/elevated_button.dart';
import 'package:ecommerceapp/screens/productdetails/widget/product_image.dart';

import 'package:ecommerceapp/screens/productdetails/widget/review_widget.dart';
import 'package:ecommerceapp/screens/productdetails/widget/specification_widget.dart';
import 'package:ecommerceapp/services/cart_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/cart_provider.dart';
import '../../widget/shoppingbag_widget.dart';

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
          appBar: Header(),
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
                DescriptionWidget(widget: widget),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                SpecificationWidget(widget: widget),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                ),
                ReviewWidget(widget: widget),
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
                          product: widget.product,
                          productId: widget.productId,
                          context: context);
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

  PreferredSize Header() {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartTotal();
    return PreferredSize(
      preferredSize: Size.fromHeight(7.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF5F6F9),
                  ),
                  child: SvgPicture.asset('assets/icons/cancel.svg'),
                ),
              ),
              const Spacer(),
              const Shoppingbag_Widget(),
            ],
          ),
        ),
      ),
    );
  }
}

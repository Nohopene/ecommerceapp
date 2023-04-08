import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/productdetails/productdetail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class ProductCard extends StatelessWidget {
  final String? category;
  final dynamic query;
  const ProductCard({super.key, this.category, this.query});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Product>(
      query: query,
      builder: (context, snapshot, _) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.21,
          ),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }

            var productIndex = snapshot.docs[index];
            Product product = productIndex.data();
            String productId = productIndex.id;

            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductDetail(
                              product: product,
                              productId: productId,
                            )));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(2.h, 0, 2.h, 2.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CachedNetworkImage(
                            imageUrl: product.imageUrl[0],
                            width: 140,
                            height: 120,
                            fit: BoxFit.contain,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  color: Colors.grey.shade200,
                                  value: downloadProgress.progress),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 5, 0, 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 2),
                                  child: Text(
                                    product.category,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                decimalDigits: 0,
                                                locale: 'vi-VN')
                                            .format(product.price),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                      if (product.percentOff! > 0)
                                        Padding(
                                          padding: EdgeInsets.only(left: 1.h),
                                          child: Text(
                                            NumberFormat.simpleCurrency(
                                                    decimalDigits: 0,
                                                    locale: 'vi-VN')
                                                .format(product.regularPrice),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey,
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 2, 0, 0),
                                  child: RatingBarIndicator(
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star_rounded,
                                      color: primaryColor,
                                    ),
                                    direction: Axis.horizontal,
                                    rating: product.rating,
                                    unratedColor: const Color(0xFF9E9E9E),
                                    itemCount: 5,
                                    itemSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (product.percentOff! > 0) _discountCard(product),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Positioned _discountCard(Product product) {
    return Positioned(
      right: -3,
      top: -3,
      child: ClipPath(
        clipper: CustomDiscountCard(),
        child: Container(
          alignment: Alignment.center,
          height: 6.h,
          padding: EdgeInsets.symmetric(horizontal: 0.8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
            color: discountColor,
          ),
          child: Text(
            '-${product.percentOff}%',
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomDiscountCard extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;

    path.lineTo(0, height);
    path.lineTo(width / 2, height * 0.85);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

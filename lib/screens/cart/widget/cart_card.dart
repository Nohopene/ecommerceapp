import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../models/cart_model.dart';
import '../../../widget/circle_icon_button.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Cart>(
      query: cartQuery(),
      builder: (context, snapshot, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            // if we reached the end of the currently obtained items, we try to
            // obtain more items
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              // Tell FirestoreQueryBuilder to try to obtain more items.
              // It is safe to call this function from within the build method.
              snapshot.fetchMore();
            }

            var cartIndex = snapshot.docs[index];
            Cart cart = cartIndex.data();
            return InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(1.15.h, 1.15.h, 1.15.h, 1.15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              width: 90,
                              height: 90,
                              imageUrl: cart.imageUrl[1],
                              fit: BoxFit.contain,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    color: Colors.grey.shade200,
                                    value: downloadProgress.progress),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(1.5.h, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                    child: Row(
                                      children: [
                                        Text(
                                          NumberFormat.simpleCurrency(
                                                  decimalDigits: 0,
                                                  locale: 'vi-VN')
                                              .format(cart.price),
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 5, 0, 0),
                                    child: Row(
                                      children: [
                                        CircleIconButton(
                                          svgIcon: 'assets/icons/subtract.svg',
                                          color: Color(0xFFF5F6F9),
                                          size: 1.2.h,
                                          onPressed: cart.quantity > 1
                                              ? () => {}
                                              : () {},
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.15.h),
                                          child: Text(
                                            '${cart.quantity}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        CircleIconButton(
                                          svgIcon: 'assets/icons/add.svg',
                                          color: Color(0xFFF5F6F9),
                                          size: 1.2.h,
                                          onPressed: cart.quantity > 1
                                              ? () => {}
                                              : () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

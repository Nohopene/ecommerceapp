import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/widget/money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import 'package:sizer/sizer.dart';

import '../../../models/cart_model.dart';

import 'counted_widget.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Cart>(
      query: cartQuery(),
      builder: (context, snapshot, _) {
        return ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
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
            String docId = cartIndex.id;
            return InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(1.15.h, 1.h, 1.15.h, 1.h),
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
                              imageUrl: cart.imageUrl[0],
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
                                        MoneyWidget(
                                            size: 13, value: cart.price),
                                        SizedBox(
                                          width: 2.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  CountedWidget(
                                    cart: cart,
                                    docId: docId,
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

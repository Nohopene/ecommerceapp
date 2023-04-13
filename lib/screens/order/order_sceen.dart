import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/models/order_model.dart';
import 'package:ecommerceapp/screens/cart/widget/cart_card.dart';
import 'package:ecommerceapp/screens/home/widget/product_card.dart';
import 'package:ecommerceapp/screens/order/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

import '../../widget/circle_icon_button.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'order-screen';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: header(),
      body: FirestoreQueryBuilder<OrderModel>(
        query: orderQuery(),
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

              var orderIndex = snapshot.docs[index];
              OrderModel order = orderIndex.data();

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
                          children: [Text('sdngkdsfhgsd')],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ));
  }

  PreferredSize header() {
    return PreferredSize(
      preferredSize: Size.fromHeight(6.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.h),
          child: Row(
            children: [
              CircleIconButton(
                size: 14,
                svgIcon: 'assets/icons/cancel.svg',
                color: const Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Text(
                'My Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

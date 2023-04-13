import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

import '../../../models/order_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<OrderModel>(
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
    );
  }
}

import 'package:ecommerceapp/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({super.key, this.query});
  final dynamic query;
  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Address>(
      query: widget.query,
      builder: (context, snapshot, _) {
        return ListView.builder(
          physics: ScrollPhysics(),
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

            var addressIndex = snapshot.docs[index];
            Address address = addressIndex.data();

            return Container(
              height: 120,
              margin: EdgeInsets.fromLTRB(1.15.h, 1.h, 1.15.h, 1.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Delivery address',
                          style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Text(
                          address.status == true ? '[Default]' : '',
                          style: const TextStyle(
                              color: primaryColor, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 135,
                          child: Text(
                            'Name:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        Text(
                          address.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 135,
                          child: Text(
                            'Phone:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        Text(
                          address.phone,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 135,
                          child: Text(
                            'Detail Address:',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            address.address,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ),
                      ],
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

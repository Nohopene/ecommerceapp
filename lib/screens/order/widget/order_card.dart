import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/services/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key});

  @override
  State<OrderCard> createState() => _CartCard1State();
}

class _CartCard1State extends State<OrderCard> {
  User? user = FirebaseAuth.instance.currentUser;
  OrderService _service = OrderService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _service.orders.where('uid', isEqualTo: user!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('No Orders. Continue shopping'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.fromLTRB(1.15.h, 1.h, 1.15.h, 1.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        'assets/icons/order.svg',
                        color: primaryColor,
                        width: 20,
                      ),
                    ),
                    title: Text(
                      data['status'],
                      style: TextStyle(
                          color: data['status'] == 'Process'
                              ? Colors.blue
                              : data['status'] == 'Complete'
                                  ? Colors.green
                                  : data['status'] == 'On the way'
                                      ? Colors.orange
                                      : Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Time: ${DateFormat.yMMMd().format(DateTime.parse(data['orderAt']))}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: Text(
                        'Total: ${NumberFormat.simpleCurrency(locale: 'vi-VN').format(data['total'])}'),
                  ),
                  ExpansionTile(
                    title: const Text(
                      'Order details',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'View order details',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.15.h, 1.h, 1.15.h, 1.h),
                        child: Column(children: [
                          Row(
                            children: const [
                              Text(
                                'Products:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                width: 45,
                                height: 45,
                                imageUrl: data['products'][index]['imageUrl']
                                    [0],
                                fit: BoxFit.contain,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.grey.shade200,
                                      value: downloadProgress.progress),
                                ),
                              ),
                            ),
                            title: Text(
                              data['products'][index]['name'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              'x${data['products'][index]['quantity']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            trailing: Text(
                                NumberFormat.simpleCurrency(locale: 'vi-VN')
                                    .format(data['products'][index]['total'])),
                          );
                        },
                        itemCount: data['products'].length,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1.15.h, 1.h, 1.15.h, 1.h),
                        child: Column(children: [
                          Row(
                            children: const [
                              Text(
                                'Delivery address:',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                              Text(
                                data['deliveryAddress']['orderName'],
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                              Text(
                                data['deliveryAddress']['phone'],
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data['deliveryAddress']['address'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 135,
                                child: Text(
                                  'Payment method:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data['paymenmethod'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

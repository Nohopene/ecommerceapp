import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/product_model.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    required this.product,
  });

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        title: const Text(
          'Specifications',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
      body: SizedBox(
        height: 400,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 2.h, 1.5.h, 2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1.8.h, 2, 1.5.h, 2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Brand: ${product!.brands}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Guarantee: ${product!.guarantee} month',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

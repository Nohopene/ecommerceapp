import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.product,
  });

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.grey.shade100,
          title: const Text(
            'Descriptions',
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
            child: Text(
              '${product!.descriptions}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ));
  }
}

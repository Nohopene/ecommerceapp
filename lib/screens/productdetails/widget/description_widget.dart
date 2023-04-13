import 'package:ecommerceapp/screens/productdetails/widget/product_description.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';
import '../productdetail_screen.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.widget,
  });

  final ProductDetail widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 0, 1.5.h, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.product!.descriptions}',
            maxLines: 3,
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ProductDescription(
                      product: widget.product,
                    );
                  });
            },
            child: const Text(
              'See all',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

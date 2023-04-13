import 'package:ecommerceapp/screens/productdetails/widget/product_infor.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../productdetail_screen.dart';

class SpecificationWidget extends StatelessWidget {
  const SpecificationWidget({
    super.key,
    required this.widget,
  });

  final ProductDetail widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.5.h, 0, 1.5.h, 0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return InformationWidget(
                      product: widget.product,
                    );
                  });
            },
            child: SizedBox(
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specifications',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,
                        size: 16,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

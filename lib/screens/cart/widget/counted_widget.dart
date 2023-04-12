import 'package:ecommerceapp/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/cart_model.dart';
import '../../../widget/circle_icon_button.dart';

class CountedWidget extends StatefulWidget {
  const CountedWidget({
    super.key,
    required this.cart,
    required this.docId,
  });

  final Cart cart;
  final String? docId;
  @override
  State<CountedWidget> createState() => _CountedWidgetState();
}

class _CountedWidgetState extends State<CountedWidget> {
  CartService _service = CartService();
  int _qty = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _qty = widget.cart.quantity;
    });

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
      child: Row(
        children: [
          CircleIconButton(
            svgIcon: 'assets/icons/subtract.svg',
            color: const Color(0xFFF5F6F9),
            size: 1.2.h,
            onPressed: widget.cart.quantity > 1
                ? () {
                    setState(() {
                      _qty--;
                    });
                    var total = _qty * widget.cart.price;
                    _service.updateQtyCart(
                        productId: widget.docId, qty: _qty, total: total);
                  }
                : () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.15.h),
            child: Text(
              _qty.toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          CircleIconButton(
              svgIcon: 'assets/icons/add.svg',
              color: const Color(0xFFF5F6F9),
              size: 1.2.h,
              onPressed: () {
                setState(() {
                  _qty++;
                });
                var total = _qty * widget.cart.price;
                _service.updateQtyCart(
                    productId: widget.docId, qty: _qty, total: total);
              }),
        ],
      ),
    );
  }
}

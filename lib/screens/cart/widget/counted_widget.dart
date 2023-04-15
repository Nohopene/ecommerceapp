import 'package:ecommerceapp/services/cart_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final CartService _service = CartService();
  int _qty = 0;
  TextEditingController _qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setState(() {
      _qty = widget.cart.quantity;
      _qtyController.text = _qty.toString();
    });

    _qtyController.selection = TextSelection.fromPosition(
        TextPosition(offset: _qtyController.text.length));
    // ignore: no_leading_underscores_for_local_identifiers
    void _showAlertDialog(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Alert'),
          content:
              const Text('Do you want to remove this product from your cart?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () {
                _service.deleteProductCart(productId: widget.docId);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

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
                : () {
                    _showAlertDialog(context);
                  },
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10.h),
          //   child: TextField(
          //     style: const TextStyle(fontSize: 14),
          //   ),
          // ),
          const SizedBox(
            width: 7,
          ),
          SizedBox(
            width: 55,
            height: 30,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              textAlign: TextAlign.center,
              controller: _qtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade200),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
              ),
              onChanged: (value) {
                setState(() {
                  var qty = int.parse(value);
                  var total = qty * widget.cart.price;
                  _service.updateQtyCart(
                      productId: widget.docId, qty: qty, total: total);
                });
              },
            ),
          ),
          const SizedBox(
            width: 7,
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

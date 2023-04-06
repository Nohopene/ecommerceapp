import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceapp/screens/productdetails/widget/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../constanst/color_constant.dart';
import '../../models/product_model.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key, this.product});
  final Product? product;
  static const String id = 'test-screen';
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

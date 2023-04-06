import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';
import '../../../models/product_model.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
    required this.product,
  });

  final Product? product;

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  Product? get product => widget.product;
  int currentPage = 0;

  void onPageChanged(index) => setState(() => currentPage = index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 35.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: PageView.builder(
            itemCount: product!.imageUrl.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: product!.imageUrl[index],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                      color: Colors.grey.shade200,
                      value: downloadProgress.progress),
                ),
              );
            },
            onPageChanged: onPageChanged,
          ),
        ),
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                product!.imageUrl.length, (index) => _buildIndicator(index)),
          ),
        ),
      ],
    );
  }

  _buildIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.only(right: 1.h),
      height: 0.7.h,
      width: currentPage == index ? 20.w : 10.w,
      decoration: BoxDecoration(
          color: currentPage == index ? primaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}

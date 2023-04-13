import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';
import '../productdetail_screen.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
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
          SizedBox(
            height: 40,
            child: InkWell(
              onTap: () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Reviews',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'See all',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade600,
                        size: 16,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, index) => const Icon(
                            Icons.star_rounded,
                            color: primaryColor,
                          ),
                          direction: Axis.horizontal,
                          rating: widget.product!.rating!.toDouble(),
                          unratedColor: const Color(0xFF9E9E9E),
                          itemCount: 5,
                          itemSize: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.product!.rating}/5',
                          style: const TextStyle(
                              fontSize: 13, color: primaryColor),
                        )
                      ],
                    ),
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

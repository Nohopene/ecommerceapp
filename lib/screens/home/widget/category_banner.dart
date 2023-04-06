import 'package:ecommerceapp/models/category_model.dart';
import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class CategoryBanner extends StatefulWidget {
  const CategoryBanner({
    super.key,
  });

  @override
  State<CategoryBanner> createState() => _CategoryBannerState();
}

class _CategoryBannerState extends State<CategoryBanner> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.h, 0, 2.h, 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PRODUCT BY CATEGORY',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 16),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: primaryColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.h, 0, 2.h, 2.h),
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                      child: FirestoreListView<Category>(
                    scrollDirection: Axis.horizontal,
                    query: categoryQuery,
                    itemBuilder: (context, snapshot) {
                      Category category = snapshot.data();
                      return Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 1.h, 4),
                        child: ActionChip(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.zero,
                          backgroundColor: _selectedCategory == category.name
                              ? primaryColor
                              : Colors.grey.shade300,
                          label: Text(
                            category.name,
                            style: TextStyle(
                                fontSize: 14,
                                color: _selectedCategory == category.name
                                    ? Colors.white
                                    : Colors.grey.shade800),
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedCategory = category.name;
                            });
                          },
                        ),
                      );
                    },
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Colors.grey.shade800,
                    ),
                  )
                ],
              ),
            ),
          ),
          ProductCard(
            query: productQuery(category: _selectedCategory),
          ),
        ],
      ),
    );
  }
}

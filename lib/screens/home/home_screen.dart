import 'package:ecommerceapp/models/product_model.dart';
import 'package:ecommerceapp/screens/cart/cart_screen.dart';
import 'package:ecommerceapp/screens/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sizer/sizer.dart';

import 'package:ecommerceapp/constanst/color_constant.dart';
import 'package:ecommerceapp/screens/home/widget/category_banner.dart';
import 'package:ecommerceapp/screens/home/widget/promo_widget.dart';
import 'package:ecommerceapp/screens/home/widget/research_widget.dart';

import 'widget/home_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: homeHeader(),
        body: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 1.h),
                const HomeBanner(),
                SizedBox(height: 3.h),
                const CategoryBanner(),
                SizedBox(height: 3.h),
                PromoWidget(),
                SizedBox(height: 3.h),
                ProductWidget(
                  widgetTile: 'POPULAR PRODUCT',
                  query: productQuery1(),
                ),
                SizedBox(height: 3.h),
                ProductWidget(
                  widgetTile: 'DISCOUNT PRODUCT',
                  query: productQuery2(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  PreferredSize homeHeader() {
    return PreferredSize(
      preferredSize: Size.fromHeight(15.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: Stack(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                child: Row(
                  children: [
                    const Text(
                      'Peachy',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(LineIcons.shoppingBag),
                      onPressed: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                    ),
                  ],
                ),
              ),
              const ResearchWidget(),
            ],
          ),
        ]),
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  String widgetTile;
  final dynamic query;
  ProductWidget({
    Key? key,
    required this.widgetTile,
    this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        SizedBox(height: 1.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widgetTile,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                'See all',
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: primaryColor),
              ),
            ],
          ),
        ),
        ProductCard(
          query: query,
        ),
        SizedBox(height: 2.h),
      ]),
    );
  }
}

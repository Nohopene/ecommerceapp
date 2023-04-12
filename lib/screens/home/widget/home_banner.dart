import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../constanst/color_constant.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final FirebaseService _service = FirebaseService();
  double scrollPositions = 0;
  final List _bannerImage = [];
  @override
  void initState() {
    getBanner();
    super.initState();
  }

  getBanner() {
    return _service.homeBanner.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(1.5.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: 20.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade300,
              ),
              child: PageView.builder(
                itemCount: _bannerImage.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: _bannerImage[index],
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: Colors.grey.shade200,
                          value: downloadProgress.progress),
                    ),
                  );
                },
                onPageChanged: (val) {
                  setState(() {
                    scrollPositions = val.toDouble();
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              _bannerImage.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: DotIndicator(
                  isActive: index == scrollPositions,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 1.h,
      width: isActive ? 5.w : 2.w,
      decoration: BoxDecoration(
          color: isActive ? primaryColor : primaryColor.withOpacity(0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

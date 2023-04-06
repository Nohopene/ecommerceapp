import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class BannerWdget extends StatefulWidget {
  const BannerWdget({super.key});

  @override
  State<BannerWdget> createState() => _BannerWdgetState();
}

class _BannerWdgetState extends State<BannerWdget> {
  final List<String> _categoryLabel = <String>[
    '*Picked For You',
    'Keyboard',
    'Mouse',
    'Screen',
    'Headphone'
  ];

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(2.h, 0, 2.h, 2.h),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         'Product by categoy',
          //         style: TextStyle(
          //             fontWeight: FontWeight.w500,
          //             letterSpacing: 1,
          //             fontSize: 16),
          //       ),
          //       Text(
          //         'See all',
          //         style: TextStyle(
          //             fontWeight: FontWeight.w500, color: primaryColor),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.h, 0, 2.h, 2.h),
            child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categoryLabel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                child: ActionChip(
                                  backgroundColor: _index == index
                                      ? primaryColor
                                      : Colors.grey,
                                  label: Text(
                                    _categoryLabel[index],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: _index == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _index = index;
                                      print(index);
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

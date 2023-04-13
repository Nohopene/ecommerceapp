import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constanst/color_constant.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget? subTitle;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onPressed;
  final bool bottomBorder;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.bottomBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          right: 15,
        ),
        decoration: BoxDecoration(
          border: _bottomBorder(),
        ),
        child: Row(
          children: [
            _leadingWidget(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                      maxLines: 2),
                  _subTitle()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: trailing ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  _subTitle() {
    return subTitle != null
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: subTitle,
          )
        : Container();
  }

  _leadingWidget() {
    return leading != null
        ? SizedBox(
            width: 20.w,
            child: leading,
          )
        : Container();
  }

  _bottomBorder() {
    return bottomBorder
        ? const Border(
            bottom: BorderSide(
              width: 1,
              color: dividerColor,
            ),
          )
        : null;
  }
}

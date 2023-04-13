// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationListTitle extends StatelessWidget {
  const LocationListTitle({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: SvgPicture.asset('assets/icons/map-pin.svg'),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 2,
          thickness: 2,
          color: Color(0xFFF8f8f8),
        )
      ],
    );
  }
}

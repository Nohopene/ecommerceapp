import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResearchWidget extends StatelessWidget {
  const ResearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.5.h),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: 'What would you search today?',
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.grey.shade500,
        ),
      ),
    );
  }
}

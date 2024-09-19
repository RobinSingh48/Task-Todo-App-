import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final TextEditingController controller;
  const Mytextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.grey[350], fontWeight: FontWeight.w500),
      controller: controller,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
          hintText: "Add Task",
          hintStyle: TextStyle(color: Colors.grey[350]),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.zero),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}

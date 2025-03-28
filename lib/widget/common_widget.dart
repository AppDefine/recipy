import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatters;
  final TextInputType textInputType;
  final int maxLength;

  const CommonTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.textInputFormatters,
    required this.textInputType,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        maxLength: maxLength,
        keyboardType: textInputType,
        controller: controller,
        inputFormatters: textInputFormatters,
        textInputAction: TextInputAction.next,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          counterText: "",
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Replace Colors.blue with your kPrimaryColor
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lisait/utils.dart';

class Custominput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final double width;
  final bool isPassword;
  final bool validate;
  final List<TextInputFormatter> formatters;

  const Custominput({
    super.key,
    required this.label,
    required this.controller,
    this.width = 300,
    this.isPassword = false,
    this.validate = true,
    this.formatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          hintText: label,
          hintStyle: TextStyle(color: Pallete.white),
        ),
        obscureText: isPassword,
        inputFormatters: formatters,
        validator: validate
            ? (value) {
                if (value == null || value.isEmpty) return "Required Field";
                return null;
              }
            : null,
      ),
    );
  }
}

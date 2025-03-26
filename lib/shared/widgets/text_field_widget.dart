import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon = false,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool suffixIcon;
  final String? Function(String?)? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscure;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator ?? (value) => null,
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon
            ? IconButton(
                onPressed: _togglePasswordVisibility,
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
        label: Text(
          widget.label,
          style: styleS14W5(Color(0xffAFAFAF)),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff78C6E7), width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff78C6E7), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff007DC0), width: 2)),
      ),
    );
  }
}

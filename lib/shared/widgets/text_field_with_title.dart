import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TextFieldWithTitle extends StatefulWidget {
  const TextFieldWithTitle({
    super.key,
    required this.controller,
    required this.title,
    this.obscure,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.maxLines,
    this.editPassword,
    this.height,
    this.enabled,
    this.title1,
  });

  final TextEditingController controller;
  final String title;
  final bool? obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? suffixIcon;
  final String? Function(String?)? validator;
  final String? hintText;
  final int? maxLines;
  final bool? editPassword;
  final double? height;
  final bool? enabled;
  final String? title1; // Add title but color is red

  @override
  State<TextFieldWithTitle> createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscure ?? false;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: styleS14W4(darkSteelGray),
            ),
            if (widget.title1 != null)
              Text(
                widget.title1!,
                style: styleS14W4(brightCrimsonRed),
              ),
          ],
        ),
        SizedBox(height: 6),
        ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (context, value, child) {
            return SizedBox(
              height: widget.height ?? 48,
              child: TextFormField(
                enabled: widget.enabled ?? true,
                style: styleS16W4(deepCharcoal).copyWith(height: 1),
                validator: widget.validator ?? (value) => null,
                controller: widget.controller,
                obscureText: _isObscured,
                keyboardType: widget.keyboardType ?? TextInputType.text,
                textInputAction: widget.textInputAction ?? TextInputAction.next,
                maxLines: widget.maxLines ?? 1,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: styleS16W4(softGray),
                  suffixIcon: widget.editPassword == true
                      ? IconButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .go('/profile/information-user/reset-password');
                          },
                          icon: SvgPicture.asset(
                              'assets/icons/profile/edit_password.svg'),
                        )
                      : widget.suffixIcon != null
                          ? IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(_isObscured
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                            )
                          : (widget.controller.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    widget.controller
                                        .clear(); // Xóa text mà không cần setState
                                  },
                                  icon: Icon(Icons.cancel, color: softGray),
                                )
                              : null),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xffE3E5E5), width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xffE3E5E5), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Color(0xff78C6E7), width: 2)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

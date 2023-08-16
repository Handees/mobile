import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hintText,
    this.onSaved,
    this.textInputType = TextInputType.text,
    this.validator,
    this.backgroundColor = const Color(0xffffffff),
    super.key,
  });

  final String hintText;
  final TextInputType textInputType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: const Color(0xff949494),
            ),
        fillColor: backgroundColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffe5e5e5),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffa8dadc),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}

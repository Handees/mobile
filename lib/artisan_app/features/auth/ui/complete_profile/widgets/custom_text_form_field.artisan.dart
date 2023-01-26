import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.hintText,
      required this.onSaved,
      this.validator,
      super.key});

  final String hintText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: const Color(0xff949494),
            ),
        fillColor: const Color(0xffffffff),
        border: const OutlineInputBorder(
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

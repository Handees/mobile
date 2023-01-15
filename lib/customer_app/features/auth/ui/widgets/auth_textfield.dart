import 'package:flutter/material.dart';

class AuthTextField extends FormField<String> {
  AuthTextField({
    Key? key,
    required String hintText,
    String? labelText,
    Widget? icon,
    TextEditingController? controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String initialValue = '',
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType? keyboardType,
    // Function()? onEditingComplete,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> state) {
            return TextField(
              onChanged: (value) {
                state.didChange(value);
              },
              controller: controller,
              obscureText: obscureText,
              textCapitalization: textCapitalization,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                errorText: "Error",
                labelText: labelText,
                hintText: hintText,
                suffixIcon: icon,
              ),
            );
          },
        );
}

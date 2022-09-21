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
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                border: Border.all(
                  width: 2.0,
                  color: Theme.of(state.context).colorScheme.onBackground,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: TextField(
                // onEditingComplete: onEditingComplete,
                onChanged: (value) {
                  state.didChange(value);
                },
                controller: controller,
                obscureText: obscureText,
                textCapitalization: textCapitalization,
                keyboardType: keyboardType,
                // cursorColor: HandeeColors.white,
                // style: const TextStyle(color: HandeeColors.white),

                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  hintText: hintText,
                  suffixIcon: icon,
                ),
              ),
            );
          },
        );
}

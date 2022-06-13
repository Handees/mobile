import 'package:flutter/material.dart';
import 'package:handee/utils/handee_colors.dart';

class AuthTextField extends FormField<String> {
  AuthTextField({
    Key? key,
    required String labelText,
    Widget? icon,
    TextEditingController? controller,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String initialValue = '',
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    bool obscureText = false,
    // Function()? onEditingComplete,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> state) {
            return Container(
              //margin: const EdgeInsets.all(8.0),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                //color: Color.fromRGBO(196, 196, 196, 0.15),
                border: Border.all(
                  width: 2,
                  color: state.hasError ? Colors.red : HandeeColors.white,
                ),
              ),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: TextField(
                  // onEditingComplete: onEditingComplete,
                  onChanged: (value) {
                    state.didChange(value);
                  },
                  controller: controller,
                  obscureText: obscureText,
                  cursorColor: HandeeColors.white,
                  style: const TextStyle(color: HandeeColors.white),

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: labelText,
                    labelStyle: const TextStyle(color: HandeeColors.white),
                    suffixIcon: icon,
                  ),
                ),
              ),
            );
          },
        );
}

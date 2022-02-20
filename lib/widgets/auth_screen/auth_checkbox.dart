import 'package:flutter/cupertino.dart';

class AuthCheckBox extends FormField<bool> {
  AuthCheckBox({
    Key? key,
    required Widget title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return Flexible(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        bool temp = state.value as bool;
                        state.didChange(!temp);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: state.value!
                              ? CupertinoColors.white
                              : CupertinoColors.black,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: state.value!
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                          ),
                        ),
                        child: Icon(
                          state.value!
                              ? CupertinoIcons.checkmark
                              : CupertinoIcons.checkmark,
                          color: state.value!
                              ? CupertinoColors.black
                              : CupertinoColors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: title,
                  ),
                ],
              ),
            );
          },
        );
}

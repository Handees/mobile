import 'package:flutter/material.dart';
import 'package:handee/handee_colors.dart';

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
            );
          },
        );
}

class PeakIconButton extends StatefulWidget {
  const PeakIconButton(this.initialIcon, this.alternateIcon, {Key? key})
      : super(key: key);

  final IconData initialIcon;
  final IconData alternateIcon;

  @override
  _PeakIconButtonState createState() => _PeakIconButtonState();
}

class _PeakIconButtonState extends State<PeakIconButton> {
  bool _peaking = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print(_peaking);
        });
        _peaking = !_peaking;
      },
      child: _peaking
          ? Icon(
              widget.alternateIcon,
              color: HandeeColors.white,
            )
          : Icon(
              widget.initialIcon,
              color: const Color.fromRGBO(89, 89, 89, 1),
            ),
    );
  }
}

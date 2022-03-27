import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:handee/handee_colors.dart';
import 'package:handee/screens/pick_location.dart';
import 'package:handee/widgets/button.dart';
import 'package:handee/widgets/loading_indicator.dart';

class BookingOverlay extends StatefulWidget {
  const BookingOverlay({Key? key}) : super(key: key);

  @override
  State<BookingOverlay> createState() => _BookingOverlayState();
}

class _BookingOverlayState extends State<BookingOverlay> {
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  final _dateNode = FocusNode();
  final _timeNode = FocusNode();
  final _addressNode = FocusNode();
  final _nameNode = FocusNode();
  final _contactNode = FocusNode();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _dateNode.dispose();
    _timeNode.dispose();
    _addressNode.dispose();
    _nameNode.dispose();
    _contactNode.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  Future<void> submit() async {
    _formKey.currentState?.save();
    setState(() {
      _isSubmitting = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pop();
  }

  Future<TimeOfDay?> setTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null /* && pickedDate TODO: SELECTED DATE */) {
      _timeController.text = '${pickedTime.hour}'.padLeft(2, '0') +
          ':' +
          '${pickedTime.minute}'.padLeft(2, '0');
    }
    return pickedTime;
  }

  Future<DateTime?> setDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 100),
      ),
    );

    if (pickedDate != null /* && pickedDate TODO: SELECTED DATE */) {
      _dateController.text = '${pickedDate.day}'.padLeft(2, '0') +
          '-' +
          '${pickedDate.month}'.padLeft(2, '0') +
          '-' +
          '${pickedDate.year}'.padLeft(4, '0');
    }

    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = 40 > MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: isKeyboardOpen ? 450 : 410,
      width: double.infinity,
      child: FractionallySizedBox(
        widthFactor: 0.85,
        alignment: Alignment.center,
        child: true //_isSubmitting
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  SizedBox(
                    child: TextLoader(),
                    width: 165,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Please contact your service provider for further enquiries',
                  ),
                  // SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: SizedBox(
                      height: 250,
                      child: CircleFadeOutLoader(
                        color: HandeeColors.blue,
                      ),
                    ),
                  ),
                ],
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      width: 50,
                      height: 6,
                      decoration: BoxDecoration(
                        color: HandeeColors.grey196,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Booking Details',
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.9,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: IgnorePointer(
                                child: BookingDetailsField(
                                  keyboardType: TextInputType.datetime,
                                  controller: _dateController,
                                  focusNode: _dateNode,
                                  fieldName: 'Date',
                                  suffixIcon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: HandeeColors.blue,
                                    size: 20,
                                  ),
                                  nextFocus: _timeNode,
                                  onSaved: (value) {
                                    //TODO: implement onSaved
                                    print(value);
                                  },
                                ),
                              ),
                              onTap: setDate,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerRight,
                            widthFactor: 0.9,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: IgnorePointer(
                                child: BookingDetailsField(
                                  focusNode: _timeNode,
                                  nextFocus: _addressNode,
                                  fieldName: 'Time',
                                  keyboardType: TextInputType.datetime,
                                  controller: _timeController,
                                  suffixIcon: const Icon(
                                    Icons.access_time,
                                    color: HandeeColors.blue,
                                    size: 20,
                                  ),
                                  onSaved: (value) {
                                    //TODO: implement onSaved
                                    print(value);
                                  },
                                ),
                              ),
                              onTap: setTime,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // async Future.delayed(const Duration(milliseconds: 0));
                        final res = await Navigator.of(context).push<String>(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (_) => const PickLocation(),
                          ),
                        );
                        _addressController.text = res ?? "";
                      },
                      child: IgnorePointer(
                        child: BookingDetailsField(
                          fieldName: 'Address',
                          focusNode: _addressNode,
                          controller: _addressController,
                          nextFocus: _nameNode,
                          onSaved: (value) {
                            //TODO: implement onSaved
                            print(value);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.9,
                            child: BookingDetailsField(
                              fieldName: 'Name',
                              focusNode: _nameNode,
                              nextFocus: _contactNode,
                              onSaved: (value) {
                                //TODO: implement onSaved
                                print(value);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerRight,
                            widthFactor: 0.9,
                            child: BookingDetailsField(
                              fieldName: 'Contact',
                              focusNode: _contactNode,
                              onSaved: (value) {
                                //TODO: implement onSaved
                                print(value);
                              },
                              onFieldSubmitted: (_) => submit(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Save as default',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: BookingCheckbox(
                              onSaved: (value) {
                                //TODO: implement onSaved
                                print(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isKeyboardOpen)
                      HandeeButton(text: 'BOOK THIS SERVICE', onTap: submit),
                  ],
                ),
              ),
      ),
    );
  }
}

class BookingDetailsField extends StatefulWidget {
  const BookingDetailsField({
    Key? key,
    this.width = double.infinity,
    this.height = 45,
    required this.fieldName,
    this.suffixIcon,
    this.focusNode,
    this.nextFocus,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.formatters,
    this.keyboardType = TextInputType.text,
    this.controller,
  }) : super(key: key);

  final double width;
  final double height;
  final String fieldName;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final void Function(String?)? onSaved;
  final String Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;
  final List<TextInputFormatter>? formatters;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  State<BookingDetailsField> createState() => _BookingDetailsFieldState();
}

class _BookingDetailsFieldState extends State<BookingDetailsField> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();

    widget.focusNode!.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (widget.focusNode!.hasFocus != _focused && mounted) {
      setState(() {
        _focused = widget.focusNode!.hasFocus;
      });
    }
  }

  void _changeFocus() {
    if (widget.nextFocus != null) {
      FocusScope.of(context).requestFocus(widget.nextFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height + 25,
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              widget.fieldName,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            focusNode: widget.focusNode,
            style: const TextStyle(
              height: 1.7,
            ),
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted ?? (_) => _changeFocus(),
            inputFormatters: widget.formatters,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: _focused ? HandeeColors.white : HandeeColors.lightBlue,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: HandeeColors.blue,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: HandeeColors.lightBlue,
                  width: 10,
                ),
              ),
              focusColor: HandeeColors.blue,
              labelStyle: const TextStyle(color: Colors.green),
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCheckbox extends FormField<bool> {
  BookingCheckbox({
    Key? key,
    FormFieldSetter<bool>? onSaved,
    bool initialValue = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          builder: (FormFieldState<bool> state) {
            return Checkbox(
              onChanged: (bool? value) {
                print(value);
                state.didChange(value);
              },
              value: state.value,
            );
          },
        );
}

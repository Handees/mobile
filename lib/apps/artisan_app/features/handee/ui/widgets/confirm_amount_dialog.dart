import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/shared_widgets/i_dialog.dart';
import 'package:handees/shared/ui/widgets/custom_text_form_field.dart';
import 'package:handees/shared/utils/utils.dart';

class ConfirmAmountDialog extends StatelessWidget {
  const ConfirmAmountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return IDialog(
      child: DialogContainer(
          height: 340,
          child: Column(
            children: [
              Image.asset('assets/icon/money.png'),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Kindly confirm the amount received for your service',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!,
              ),
              const SizedBox(
                height: 16,
              ),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: CustomTextFormField(
                  hintText: 'Amount',
                  textInputType: TextInputType.number,
                  backgroundColor: getHexColor('f2f3f4'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Done',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          letterSpacing: .64,
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/profile/ui/widgets/circle_with_svg_image.dart';

class EditEmail extends ConsumerWidget {
  const EditEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email'),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const CircleAvatarWithSvgImage(
                imagePath: 'assets/svg/email_image.svg'),
            const SizedBox(height: 23),
            const TextField(keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 30),
            Text(
              'Changing the email linked to your account will be complete when the new email has been verified.',
              maxLines: 2,
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).disabledColor,
              ),
            ),
            const Spacer(flex: 2),
            // const SizedBox(height: 130),
            SizedBox(
              width: double.infinity,
              height: 64,
              child: FilledButton(
                onPressed: () {},
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/profile/ui/widgets/circle_with_svg_image.dart';
import 'package:handees/apps/customer_app/profile/ui/widgets/profile_edit_text_field.dart';

class EditEmail extends ConsumerWidget {
  const EditEmail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = (mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Email'),
        scrolledUnderElevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: availableHeight,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    // TODO: Fix SVG not displaying in Circle
                    const CircleAvatarWithSvgImage(
                        imagePath: 'assets/svg/email_image.svg'),
                    //TEST
                    // const CircleAvatarWithSvgImage(
                    //     imagePath: 'assets/svg/handee_artisan_home_bg.svg'),
                    const SizedBox(height: 23),
                    const ProfileEditingTextField(
                        keyboard: TextInputType.emailAddress),
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
            ),
          )
        ],
      ),
    );
  }
}

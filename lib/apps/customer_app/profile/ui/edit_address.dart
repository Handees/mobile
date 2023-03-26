import 'package:flutter/material.dart';
import 'package:handees/apps/customer_app/profile/ui/widgets/profile_edit_text_field.dart';

class EditAddress extends StatelessWidget {
  const EditAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final availableHeight = (mediaQuery.size.height -
        AppBar().preferredSize.height -
        mediaQuery.padding.top);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.clear,
              size: 25,
            )),
        title: const Text('Address'),
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
                    // const SizedBox(height: 70),
                    const Spacer(),
                    const ProfileEditingTextField(
                        keyboard: TextInputType.streetAddress),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28.0,
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Icon(Icons.home_rounded),
                        ),
                        const Spacer(),
                        Text(
                          " 24/7 garri avenue off swallow spit street",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(flex: 5),
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
          ),
        ],
      ),
    );
  }
}

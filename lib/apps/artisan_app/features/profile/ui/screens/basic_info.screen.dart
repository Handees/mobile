import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/ui/widgets/custom_text_form_field.dart';

class BasicInfoScreen extends ConsumerWidget {
  BasicInfoScreen({super.key});

  final double horizontalPadding = 16.0;

  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Basic Information",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "We are required to ask  for your basic information to verify your identity",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: const Color(0xff949494)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        hintText: "First Name",
                        defaultValue: user.firstName,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        hintText: "Last Name",
                        defaultValue: user.lastName,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CustomTextFormField(
                        hintText: "Address",
                        defaultValue: user.address,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        "Contact Information",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        hintText: "Phone Number",
                        defaultValue: user.telephone,
                      ),
                      const SizedBox(height: 32.0),
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Done'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

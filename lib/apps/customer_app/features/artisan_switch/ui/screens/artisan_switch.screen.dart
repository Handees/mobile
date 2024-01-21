import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/features/artisan_switch/providers/artisan_switch.provider.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/data/handees/job_category.dart';
import 'package:handees/shared/routes/routes.dart';
import 'package:handees/shared/ui/widgets/custom_text_form_field.dart';

class ArtisanSwitchScreen extends ConsumerStatefulWidget {
  const ArtisanSwitchScreen({super.key});

  @override
  ConsumerState<ArtisanSwitchScreen> createState() =>
      _ArtisanSwitchScreenState();
}

class _ArtisanSwitchScreenState extends ConsumerState<ArtisanSwitchScreen> {
  final double horizontalPadding = 16.0;

  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final artisanSwitchState = ref.watch(artisanSwitchStateProvider);
    final artisanSwitchStateNotifier =
        ref.watch(artisanSwitchStateProvider.notifier);

    final userStateNotifier = ref.watch(userProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Extra Information",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "We need some more information to register you as an artisan",
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
                      hintText: "Hourly Rate",
                      onSaved: artisanSwitchStateNotifier.onHourlyRateSaved,
                      textInputType: TextInputType.number,
                      validator: artisanSwitchStateNotifier.hourlyRateValidator,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomTextFormField(
                      hintText: "Job Title",
                      onSaved: artisanSwitchStateNotifier.onJobTitleSaved,
                      validator: artisanSwitchStateNotifier.jobTitleValidator,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffe5e5e5),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: const Row(
                        children: <Widget>[
                          Text("Job Category: "),
                          SizedBox(
                            width: 8,
                          ),
                          JobCategoryDropdown(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: FilledButton(
                        onPressed: artisanSwitchState ==
                                ArtisanSwitchState.loading
                            ? null
                            : () {
                                if (!_formGlobalKey.currentState!.validate()) {
                                  return;
                                }
                                _formGlobalKey.currentState!.save();
                                artisanSwitchStateNotifier.createArtisanProfile(
                                    onSuccess: () async {
                                  userStateNotifier.getUserObject().then(
                                      (value) => Navigator.of(context,
                                              rootNavigator: true)
                                          .pushReplacementNamed(
                                              ArtisanAppRoutes.home));
                                });
                              },
                        child: artisanSwitchState == ArtisanSwitchState.loading
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  backgroundColor: Colors.black,
                                ),
                              )
                            : const Text('Done'),
                      ),
                    ),
                    // const SizedBox(height: 16.0),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 64,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: const Text(
                    //       'Cancel',
                    //     ),
                    //   ),
                    // ),
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

class JobCategoryDropdown extends ConsumerStatefulWidget {
  const JobCategoryDropdown({super.key});

  @override
  ConsumerState<JobCategoryDropdown> createState() =>
      _JobCategoryDropdownState();
}

class _JobCategoryDropdownState extends ConsumerState<JobCategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    final artisanSwitchStateNotifier =
        ref.watch(artisanSwitchStateProvider.notifier);
    final jobCategory = ref.watch(jobCategoryProvider);

    return DropdownButton(
        value: jobCategory,
        items: JobCategory.values
            .map<DropdownMenuItem<JobCategory>>(
              (iJobCategory) => DropdownMenuItem<JobCategory>(
                value: iJobCategory,
                child: Text(iJobCategory.name),
              ),
            )
            .toList(),
        onChanged: artisanSwitchStateNotifier.onJobCategoryChanged);
  }
}

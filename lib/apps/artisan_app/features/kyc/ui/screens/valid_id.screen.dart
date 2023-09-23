import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/image_upload/providers/image_upload.provider.dart';
import 'package:handees/apps/artisan_app/features/kyc/providers/id_info.provider.dart';
import 'package:handees/apps/artisan_app/features/kyc/ui/widgets/id_type_card.dart';
import 'package:handees/apps/artisan_app/features/image_upload/widgets/image_upload.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/data/user/models/artisan.model.dart';
import 'package:handees/shared/data/user/user_repository.dart';
import 'package:handees/shared/services/auth_service.dart';
import 'package:handees/shared/ui/widgets/custom_text_form_field.dart';
import 'package:handees/shared/utils/utils.dart';
import 'package:intl/intl.dart';

class ValidIDScreen extends ConsumerStatefulWidget {
  const ValidIDScreen({super.key});

  @override
  ConsumerState<ValidIDScreen> createState() => _ValidIDScreenState();
}

class _ValidIDScreenState extends ConsumerState<ValidIDScreen> {
  final double horizontalPadding = 16.0;
  bool isKycFormLoading = false;
  String storagePath = '';

  String getUploadFileName(WidgetRef ref) {
    final idType = ref.read(idTypeProvider);
    if (idType == idTypes[0]) return 'NIN Slip';
    if (idType == idTypes[1]) return 'Drivers\' license';
    if (idType == idTypes[2]) return 'Passport Data Page';
    return '';
  }

  List<Widget> getIdTypeForm() {
    final idType = ref.watch(idTypeProvider);
    switch (idType) {
      case IDTypes.nin:
        return [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: CustomTextFormField(
              hintText: 'NIN Number',
              textInputType: TextInputType.number,
              onFieldSubmitted: (String? value) {
                if (value != null) {
                  ref.read(idInfoProvider.notifier).updateNIN(value);
                }
              },
            ),
          )
        ];
      case IDTypes.driverLicense:
        return [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: CustomTextFormField(
              hintText: 'FRSC Number',
              onFieldSubmitted: (String? value) {
                if (value != null) {
                  ref.read(idInfoProvider.notifier).updateFrscNo(value);
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  const Text('Date Of Birth:'),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(DateFormat.yMd()
                      .format(ref.watch(idInfoProvider).dateOfBirth)),
                  const SizedBox(
                    width: 16,
                  ),
                  FilledButton(
                      onPressed: () async {
                        final chosenDate = await showDatePicker(
                            context: context,
                            initialDate: ref.read(idInfoProvider).dateOfBirth,
                            firstDate: DateTime(1930),
                            lastDate: DateTime(2100));

                        if (chosenDate != null) {
                          ref
                              .read(idInfoProvider.notifier)
                              .updateDOB(chosenDate);
                        }
                      },
                      child: const Text('Select DOB'))
                ],
              )),
        ];
      case IDTypes.passport:
        return [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: CustomTextFormField(
              hintText: 'Last Name',
              textInputType: TextInputType.number,
              onFieldSubmitted: (String? value) {
                if (value != null) {
                  ref.read(idInfoProvider.notifier).updateLastName(value);
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: CustomTextFormField(
              hintText: 'Passport Number',
              onFieldSubmitted: (String? value) {
                if (value != null) {
                  ref.read(idInfoProvider.notifier).updatePassportNo(value);
                }
              },
            ),
          )
        ];
      default:
        return [];
    }
  }

  void submitIdForm(
      {required VoidCallback onSuccess,
      required VoidCallback onFailure}) async {
    final validationResult = ref.read(idInfoProvider.notifier).validate();

    if (validationResult.isNotEmpty) {
      displaySnackbar(context, validationResult);
      return;
    }
    setState(() {
      isKycFormLoading = true;
    });
    Map<String, dynamic> body = {};
    final idType = ref.read(idTypeProvider);

    switch (idType) {
      case IDTypes.nin:
        body = {
          "kyc_type": "nin",
          "number": ref.read(idInfoProvider).nin,
          "image": ref.read(idInfoProvider).imageUrl
        };
        break;
      case IDTypes.driverLicense:
        body = {
          "kyc_type": "drivers_license",
          "dob": formatDateYMD(ref.read(idInfoProvider).dateOfBirth),
          "number": ref.read(idInfoProvider).nin,
          "image": ref.read(idInfoProvider).imageUrl
        };
        break;
      case IDTypes.passport:
        body = {
          "kyc_type": "passport",
          "last_name": ref.read(idInfoProvider).lastName,
          "number": ref.read(idInfoProvider).passportNo,
          "image": ref.read(idInfoProvider).imageUrl
        };
        break;
    }

    final userRepository = UserRepository();
    final kycResponse = await userRepository.submitKycData(
      body: body,
      token: AuthService.instance.token,
    );

    setState(() {
      isKycFormLoading = false;
    });

    if (!kycResponse) {
      onFailure();
    } else {
      onSuccess();
    }

    //TODO: Figure out what to do if the kycResponse is true
  }

  @override
  void dispose() {
    ref.invalidate(idInfoProvider);
    ref.invalidate(imageUploadProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idType = ref.watch(idTypeProvider);
    final userId = ref.watch(userProvider).userId;

    final imageUrl = ref.watch(idInfoProvider).imageUrl;

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Valid ID",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Please kindly upload any of the valid means of identification specified below",
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
              padding: EdgeInsets.only(left: horizontalPadding),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - horizontalPadding,
                height: 40,
                child: ListView.separated(
                  itemCount: idTypes.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (ctx, idx) => const SizedBox(width: 8.0),
                  itemBuilder: (BuildContext ctx, int index) {
                    return InkWell(
                      onTap: (() {
                        ref.read(idTypeProvider.notifier).state =
                            idTypes[index];
                        ref.invalidate(idInfoProvider);
                        ref.invalidate(imageUploadProvider);
                      }),
                      child: IDTypeCard(
                        idTypes[index],
                        idType == idTypes[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                ImageUpload(
                  fileType: getUploadFileName(ref),
                  uploadedImageUrl: imageUrl,
                  updateImageUrl: (String uploadedImageUrl) {
                    ref
                        .read(idInfoProvider.notifier)
                        .updateImageUrl(uploadedImageUrl);
                  },
                  storagePath: "${formatString(idType)}/$userId",
                ),
                const SizedBox(height: 20),
                ...getIdTypeForm(),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  width: double.infinity,
                  height: 64,
                  child: FilledButton(
                    onPressed: isKycFormLoading
                        ? () {}
                        : () => submitIdForm(
                              onSuccess: () {
                                ref
                                    .read(userProvider.notifier)
                                    .updateKycStatus(KYCStatus.inProgress);
                                Navigator.of(context).pop();
                                displaySnackbar(context,
                                    'KYC details submitted successfully');
                              },
                              onFailure: () {
                                displaySnackbar(
                                    context, 'KYC Submission Failed');
                              },
                            ),
                    child: isKycFormLoading
                        ? const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
        ],
      ),
    );
  }
}

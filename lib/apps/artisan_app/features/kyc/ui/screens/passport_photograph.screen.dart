import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/artisan_app/features/image_upload/providers/image_upload.provider.dart';
import 'package:handees/apps/artisan_app/features/image_upload/widgets/image_upload.dart';
import 'package:handees/apps/customer_app/features/home/providers/user.provider.dart';
import 'package:handees/shared/utils/utils.dart';

final passportUrlProvider = StateProvider((ref) => '');

class PasspportPhotographScreen extends ConsumerStatefulWidget {
  const PasspportPhotographScreen({super.key});

  @override
  ConsumerState<PasspportPhotographScreen> createState() =>
      _PasspportPhotographScreenState();
}

class _PasspportPhotographScreenState
    extends ConsumerState<PasspportPhotographScreen> {
  final double horizontalPadding = 16.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ref.invalidate(passportUrlProvider);
    ref.invalidate(imageUploadProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passportUrl = ref.watch(passportUrlProvider);
    final userId = ref.watch(userProvider).userId;

    dPrint(passportUrl);
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
                    "Passport Photograph",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Please kindly upload your profile picture",
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
            child: SizedBox(
              height: 520,
              child: Column(
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  ImageUpload(
                    fileType: 'Passport Photograph',
                    uploadedImageUrl: passportUrl,
                    updateImageUrl: (String imageUrl) {
                      ref.read(passportUrlProvider.notifier).state = imageUrl;
                    },
                    storagePath: "passport-photograph/$userId",
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    width: double.infinity,
                    height: 64,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
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
        ],
      ),
    );
  }
}

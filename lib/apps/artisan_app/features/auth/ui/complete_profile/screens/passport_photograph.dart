import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/auth/ui/complete_profile/widgets/image_upload.dart';

class PasspportPhotographScreen extends StatefulWidget {
  const PasspportPhotographScreen({super.key});

  @override
  State<PasspportPhotographScreen> createState() =>
      _PasspportPhotographScreenState();
}

class _PasspportPhotographScreenState extends State<PasspportPhotographScreen> {
  final double horizontalPadding = 16.0;

  @override
  Widget build(BuildContext context) {
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
                  const ImageUpload(),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    width: double.infinity,
                    height: 64,
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text('Done'),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handees/apps/customer_app/home/providers/home_provider.dart';
import 'package:handees/apps/customer_app/profile/providers/profile_provider.dart';
import 'package:handees/data/user/models/user.dart';
import 'package:handees/res/icons.dart';
import 'package:handees/routes/routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider);
    final addresses = user.addresses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SIGNED IN AS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.0),
                  _ProfileTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(CustomerAppRoutes.editPrimary),
                    leadingIcon: Icon(Icons.account_circle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          user.phone,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'EMAIL',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 16.0),
                  _ProfileTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(CustomerAppRoutes.editEmail),
                    leadingIcon: Icon(Icons.mail),
                    child: Text(
                      user.email,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'ADDRESS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  for (int i = 0; i < addresses.length; ++i)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: _ProfileTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(CustomerAppRoutes.editAddress),
                        leadingIcon: Icon(Icons.book_rounded),
                        child: Text(
                          addresses[i],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  SizedBox(height: 16.0),
                  _ProfileTile(
                    onTap: () => Navigator.of(context)
                        .pushNamed(CustomerAppRoutes.editAddress),
                    leadingIcon: Icon(Icons.add),
                    child: Text(
                      'Add a new address',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: null,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: InkWell(
                      onTap: () {
                        ref.read(profileProvider.notifier).signoutUser();
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacementNamed(AuthRoutes.signin);
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            child: Icon(Icons.exit_to_app_rounded),
                            backgroundColor:
                                Theme.of(context).colorScheme.errorContainer,
                            foregroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            'Sign out',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    super.key,
    required this.leadingIcon,
    required this.child,
    this.trailing = const SizedBox.square(
      dimension: 48.0,
      child: Icon(Icons.edit),
    ),
    this.onTap,
  });

  final Icon leadingIcon;
  final Widget child;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(width: 16.0),
          CircleAvatar(
            radius: 28.0,
            child: leadingIcon,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 20.0),
          Expanded(child: child),
          SizedBox(width: 8.0),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

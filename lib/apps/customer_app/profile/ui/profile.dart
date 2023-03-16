import 'package:flutter/material.dart';
import 'package:handees/res/icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    leadingIcon: Icon(Icons.account_circle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Eje Sapawanwundme',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '+23481999000364',
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
                    leadingIcon: Icon(Icons.mail),
                    child: Text(
                      'dome2k@gmail.com',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Text(
                    'ADDRESS',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.0),
                  for (int i = 0; i < 2; ++i)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: _ProfileTile(
                        leadingIcon: Icon(Icons.book_rounded),
                        child: Text(
                          '24/7 Garri Avenue',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  SizedBox(height: 16.0),
                  _ProfileTile(
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
                      onTap: () {},
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

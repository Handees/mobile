import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:handees/apps/artisan_app/features/home/screens/home_nav/widgets/icon_avatar.dart';
import 'package:handees/routes/routes.dart';
import 'package:handees/theme/theme.dart';

class AcceptHandeeDialog extends StatelessWidget {
  const AcceptHandeeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 250,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "3 mins",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    "4.0km",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Color(0xffe63946),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const IconAvatar(),
                  const SizedBox(width: 16.0),
                  Text(
                    "Jane Foster",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    "4.5",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 12),
                  ),
                  const Icon(
                    Icons.star,
                    color: Color(0xffffe186),
                    size: 14,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.construction_outlined,
                      color: Color(0xffa4a1a1),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "Additional Information",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffa4a1a1),
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(left: 12.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xffa4a1a1),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      "15, Changes Business Street, Yaba, Lagos",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffa4a1a1),
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                height: 54,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(ArtisanAppRoutes.chat),
                  style: Theme.of(context)
                      .extension<ButtonThemeExtensions>()
                      ?.filled!
                      .copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff14161c)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                  child: Text(
                    "Accept",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bus_app/src/features/core/utils/circular_container.dart';
import 'package:flutter/material.dart';

class TUserProfile extends StatelessWidget {
  const TUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: tCircularContainer(
        image: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text('Strathmover Passenger',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white)),
      subtitle: Text('user@email.com',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: Colors.white)),
      trailing: IconButton(
        onPressed: () {}, icon: const Icon(Iconsax.edit, color: Colors.white)),
      );
  }
}
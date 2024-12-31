import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? userImage;

  const ProfileAvatar({super.key, this.userImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      backgroundImage: (userImage != null && userImage!.isNotEmpty)
          ? NetworkImage(userImage!) as ImageProvider
          : null,
      child: (userImage == null || userImage!.isEmpty)
          ? const Icon(Icons.person, size: 30)
          : null,
    );
  }
}

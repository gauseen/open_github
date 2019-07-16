import 'package:flutter/material.dart';

class AvatarIcon extends StatelessWidget {
  AvatarIcon({
    @required this.avatarUrl,
    this.width = 40.0,
    this.height = 40.0,
    this.defaultAvatarUrl = 'assets/images/avatar.png',
  });

  final String avatarUrl;
  final String defaultAvatarUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            width: width,
            height: height,
            placeholder: '$defaultAvatarUrl',
            image: '$avatarUrl'),
      ),
      onTap: () {
        print('avatar clicked');
      },
    );
  }
}

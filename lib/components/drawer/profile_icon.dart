import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final int? radius;

  const ProfileIcon({
    super.key,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    var service = AuthService();
    var r = (radius ?? 70).toDouble();

    return StreamBuilder<User?>(
      stream: service.listenToAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var user = snapshot.data!;

        if (user.photoURL != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(r),
            child: CachedNetworkImage(
              imageUrl: user.photoURL!,
              fit: BoxFit.cover,
              height: r,
              width: r,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error),
              ),
            ),
          );
        }

        return CircleAvatar(
          backgroundImage: AssetImage('assets/adaptLogo.png'),
          radius: 30,
        );
      },
    );
  }
}

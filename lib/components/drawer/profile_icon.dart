import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {
  final int? radius;
  final String? image;
  final bool isExternal;

  const ProfileIcon({
    super.key,
    this.radius,
    this.image,
    this.isExternal = false,
  });

  Widget template({
    required double r,
  }) {
    return CircleAvatar(
      backgroundImage: AssetImage('assets/avatar.png'),
      radius: r.toDouble() - 14,
    );
  }

  Widget networkImage(String url, double r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        height: r,
        width: r,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
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

  @override
  Widget build(BuildContext context) {
    var service = AuthService();
    var r = (radius ?? 60).toDouble();

    return StreamBuilder<User?>(
      stream: service.listenToAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (isExternal) {
          return networkImage(image!, r);
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

        return template(r: r);
      },
    );
  }
}

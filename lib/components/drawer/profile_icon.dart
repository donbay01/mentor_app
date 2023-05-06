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
      radius: r.toDouble() - 25,
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
          child: Image(
            image: AssetImage('assets/adaptLogo.png'),
          ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var user = snapshot.data!;
        if (image == null) {
          return template(r: r);
        }

        if (isExternal && image != null) {
          return networkImage(image!, r);
        }

        if (user.photoURL != null) {
          return networkImage(
            user.photoURL!,
            r,
          );
        }

        return template(r: r);
      },
    );
  }
}

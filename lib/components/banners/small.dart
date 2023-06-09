import 'package:career_paddy/pages/profile/edit_paddyProfile.dart';
import 'package:career_paddy/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../constants/role.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SmallBanners extends StatelessWidget {
  const SmallBanners({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = context.watch<UserProvider>().getUser;

    return FlutterCarousel(
      options: CarouselOptions(
        padEnds: false,
        enableInfiniteScroll: true,
        height: size.height * 0.13,
        showIndicator: false,
        autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5) ,
        floatingIndicator: false,
        viewportFraction: 1,
        scrollDirection: Axis.vertical
      ),
      items: [
        SvgPicture.asset(
          'assets/Career.svg',
          fit: BoxFit.contain,
          height: 100,
        ),
        SvgPicture.asset(
          'assets/Interview.svg',
          fit: BoxFit.contain,
          height: 100,
        ),
      ],
    );
  }
}

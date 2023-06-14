import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class LinkService {
  static var dl = FirebaseDynamicLinks.instance;
  static final dynamicLinkParams = DynamicLinkParameters(
    link: Uri.parse("https://careerpaddy.page.link/"),
    uriPrefix: "https://careerpaddy.page.link/",
    androidParameters:
        const AndroidParameters(packageName: "com.careerpaddy.CareerPaddy"),
    iosParameters: const IOSParameters(bundleId: "com.careerpaddy.CareerPaddy"),
  );

  static Future<Uri> buildLink() async {
    var link = await dl.buildLink(dynamicLinkParams);
    return link;
  }

  static Future<Uri> buildShort() async {
    var link = await dl.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.unguessable,
    );
    return link.shortUrl;
  }

  static handleLinks() async {
    final PendingDynamicLinkData? initialLink = await dl.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
    }
  }
}

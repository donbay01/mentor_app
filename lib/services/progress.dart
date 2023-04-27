import 'package:flutter/cupertino.dart';
import 'package:overlay_progress_indicator/overlay_progress_indicator.dart';

class ProgressService {
  static Future<void> show(BuildContext context) {
    return OverlayProgressIndicator.show(
      context: context,
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
  }

  static Future<void> hide() {
    return OverlayProgressIndicator.hide();
  }
}

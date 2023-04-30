import 'package:career_paddy/pages/payment/payment_failed.dart';
import 'package:career_paddy/pages/payment/payment_successful.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebview extends StatefulWidget {
  final String url;

  const PaymentWebview({
    super.key,
    required this.url,
  });

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  var controller = WebViewController();

  success() {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PaymentSuccessful(),
      ),
    );
  }

  error() {
    Navigator.pop(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PaymentFailed(),
      ),
    );
  }

  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            var navigation = change.url!;

            if (navigation.contains('https://careerpaddy.page.link/')) {
              return success();
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            var navigation = request.url;

            if (navigation == 'https://standard.paystack.co/close') {
              return success();
            }

            if (navigation.contains('https://careerpaddy.page.link/')) {
              return success();
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: error,
        ),
        title: Text('Checkout'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

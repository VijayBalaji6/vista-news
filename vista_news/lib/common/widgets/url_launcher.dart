import 'package:url_launcher/url_launcher.dart';

class CommonServices {
  static Future<void> openWebPage(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

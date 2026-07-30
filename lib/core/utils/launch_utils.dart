import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> openEmail(String email, {String? subject}) async {
  final uri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: subject != null ? {'subject': subject} : null,
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

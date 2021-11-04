import 'package:themoviedb/configuration/network_configuration.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class WebPageLauncher {
  static Future<bool> signUp() async => openPage(NetworkConfiguration.signupUrl);

  static Future<bool> openFacebook(String facebookId) async =>
      openPage('https://www.facebook.com/' + facebookId);

  static Future<bool> openTwitter(String twitterId) async =>
      openPage('https://mobile.twitter.com/' + twitterId);

  static Future<bool> openInstagram(String instagramId) async =>
      openPage('https://www.instagram.com/' + instagramId);

  static Future<bool> openPage(String url) async {
    if (await canLaunch(url)) return launch(url);
    return false;
  }
}

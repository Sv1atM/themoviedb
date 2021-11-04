import 'package:themoviedb/configuration/network_configuration.dart';

abstract class ImageDownloader {
  static String makeUrl(String path) => NetworkConfiguration.imageUrl + path;
}

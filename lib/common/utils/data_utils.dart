import 'package:eunbinlib_app/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return 'http://$ip$path';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((path) => pathToUrl(path)).toList();
  }

  static DateTime stringToDatetime(String value) {
    return DateTime.parse(value);
  }
}

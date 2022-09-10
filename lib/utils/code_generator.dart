import 'package:random_string/random_string.dart';

class CodeGenerator {
  static String generateCode(String prefix) {
    final randomCode = randomAlphaNumeric(8);
    return '$prefix-$randomCode';
  }
}

import 'package:meta/meta.dart';

export 'internal.dart' show Helper; // Warning: internal class can't be exported

class PublicApi {
  void perform() => Helper().foo();
}

void main() {
  PublicApi().perform();
  Helper().foo(); // Shows warning in IDE, if used outside using class directly.
}

@internal // ignore: invalid_internal_annotation, just an example.
class Helper {
  void foo() => print('Doing internal work');
}

import 'package:meta/meta.dart';

/// Generic serializer used by small tools/tests to parse inputs.
class Serializer<T> {
  const Serializer(this.parse);
  final T Function(Object? input) parse;
}

/// Same API, but callers may omit type arguments anywhere it's referenced.
@optionalTypeArgs
class FriendlySerializer<T> {
  const FriendlySerializer(this.parse);
  final T Function(Object? input) parse;
}

int parsePort(Object? v) => int.parse(v.toString());

// Non-annotated: returning a raw generic type is flagged by analyzer when
// strict-raw-types is enabled.
Serializer makeRawSerializer() => Serializer((v) => v.toString());

void main() {
  // Non-annotated (shows analyzer warning on the variable type).
  Serializer rawS = Serializer((v) => v.toString());

  // Annotated (allowed to omit <T> on both sides):
  FriendlySerializer rawF = FriendlySerializer((v) => v.toString());

  // Typical explicit-typed usage still works for both:
  final portS = Serializer<int>(parsePort);
  final portF = FriendlySerializer<int>(parsePort);

  final stringS = Serializer<String>((v) => v.toString());
  print(stringS.parse(123)); // "123"
  print(rawF.parse('456')); // "456"
  print(portS.parse('8080')); // 8080
  print(portF.parse('3000')); // 3000

  // Inference on the annotated version at the call site:
  final inferredF = FriendlySerializer(
    (v) => (v as Map<String, String>)['PORT'] ?? '',
  );
  print(inferredF.parse({'PORT': '9090'}));
}

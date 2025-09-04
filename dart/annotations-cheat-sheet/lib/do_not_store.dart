import 'package:meta/meta.dart';

/// Annotated: the returned value must not be stored (in fields, top-level vars).
@doNotStore
String newCsrfToken() => DateTime.now().microsecondsSinceEpoch.toString();

// Non-annotated: a stable identifier that is safe to cache.
String stableUserId() => 'user-123';

final cachedTokenGood = stableUserId(); // No analyzer warning.
final cachedTokenWrong = newCsrfToken(); // Has analyzer warning.

void main() {
  print('stable id cached: $cachedTokenGood');
  print('ephemeral id cached: $cachedTokenWrong');
}

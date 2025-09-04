/// Old API; use `hashV2` instead.
@Deprecated('Use hashV2')
int hashV1(String input) => input.hashCode;

/// Replacement API with clearer semantics.
int hashV2(String input) => Object.hashAllUnordered([input, 0xC0DE]);

void main() {
  // Deprecated: analyzer warns with the deprecation message.
  final a = hashV1('abc'); // Analyzer: deprecated_member_use_from_same_package
  final b = hashV2('abc'); // Preferred: no warning.
  print({'v1': a, 'v2': b}); // Keep program runnable.
}

import 'package:meta/meta.dart';

class Sanitizer {
  /// Return a cleaned string; the result must be used by callers.
  @useResult
  String cleaned(String s) => s.trim();

  /// Non-annotated transform; ignoring the result is allowed.
  String uppercased(String s) => s.toUpperCase();
}

void main() {
  final sanitizer = Sanitizer();
  // Annotated: ignoring the result is flagged by the analyzer.
  sanitizer.cleaned('  keep me  '); // ! Analyzer: unused_result
  // Non-annotated: ignoring the result is allowed.
  sanitizer.uppercased('ignore me');
  // Proper usage: capture and use the cleaned value.
  final c = sanitizer.cleaned('  x  ');
  print('[$c]');
}

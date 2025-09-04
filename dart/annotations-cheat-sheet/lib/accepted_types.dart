import 'package:dart_code_metrics_annotations/annotations.dart';

/// Only accepts [String] or [int] for a "retry" config value.
void applyRetry(@AcceptedTypes({String, int}) Object value) => print(value);

/// Unrestricted metadata value (no annotation, any [Object] is allowed).
void applyTag(Object value) => print(value);

void main() {
  applyTag(true); // No annotation, no warning...
  applyRetry(true); // Warning: pass-correct-accepted-type
  applyRetry(3); // No warning here, proper type provided.
}

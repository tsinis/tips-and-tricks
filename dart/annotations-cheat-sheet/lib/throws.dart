import 'package:dart_code_metrics_annotations/annotations.dart';

/// Parses the PORT env value. Throws [FormatException] when empty or invalid.
@Throws({FormatException})
int readPort(String env) {
  if (env.isEmpty) throw const FormatException('PORT is empty');
  return int.parse(env);
}

/// Throws but not annotated; DCM will suggest adding [@Throws].
int readTimeout(String env) {
  if (env.isEmpty) throw const FormatException('TIMEOUT is empty');
  return int.parse(env);
}

void main() {
  readTimeout(''); // No annotation, no warning... But with runtime exception!
  readPort(''); // Also exception, but with warning: handle-throwing-invocations
  try {
    readPort('8080'); // No warning here, correctly handled.
  } catch (_) {}
}

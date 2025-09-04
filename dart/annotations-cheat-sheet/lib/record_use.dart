import 'package:meta/meta.dart';

/// Calls are recorded for post-compile tooling.
@RecordUse()
void auditLog(String message, {String level = 'info'}) {
  // No-op in this demo.
}

/// Regular function; calls are not recorded.
void debugLog(String message, {String level = 'info'}) {
  // No-op in this demo.
}

void main() {
  auditLog('app started'); // Recorded.
  debugLog('app started'); // Not recorded.
}

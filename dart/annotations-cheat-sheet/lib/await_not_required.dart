import 'dart:async';
import 'package:meta/meta.dart';

/// Non-annotated: callers should await or otherwise handle the [Future].
Future<void> writeAuditLog(String message) async {
  await Future<void>.delayed(const Duration(milliseconds: 10));
  print('[audit] $message');
}

/// Annotated: explicitly fire-and-forget. Callers can drop the Future.
@awaitNotRequired
Future<void> queueTelemetry(String event) async {
  await Future<void>.delayed(const Duration(milliseconds: 5));
  print('[telemetry] $event');
}

void main() {
  writeAuditLog('user signed in'); // Analyzer warning for discarded future.
  queueTelemetry('session-started'); // OK due to @awaitNotRequired.
  unawaited(writeAuditLog('user signed in and awaited')); // Explicitly handle.
  // In production code prefer: await writeAuditLog(...); here we keep main sync.
}

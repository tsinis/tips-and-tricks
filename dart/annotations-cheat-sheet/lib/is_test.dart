import 'dart:async';

import 'package:meta/meta.dart';

/// Test DSL wrapper recognized by IDE as a test entry point.
/// In a real project, delegate to `test(name, body)` from package:test.
@isTest
void it(String name, Future<void> Function() body) => body();

/// Group wrapper recognized by IDE as a test group.
/// In a real project, delegate to `group(name, body)` from package:test.
@isTestGroup
void describe(String name, void Function() body) => body();

// Unannotated counterparts (plain functions; no special test discovery/run icons).
void itRaw(String name, Future<void> Function() body) => body();
void describeRaw(String name, void Function() body) => body();

void main() {
  // Annotated: IDE shows test run affordances and discovery here.
  describe('sanitizer', () {
    it('trims', () async {
      // test body
    });
  });

  // Unannotated: plain functions; no test run affordances here.
  describeRaw('sanitizer-raw', () {
    itRaw('trims-raw', () async {
      // test body
    });
  });
}

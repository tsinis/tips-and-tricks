import 'package:git_tips/main.dart';
import 'package:test/test.dart';

void main() {
  group('statusCategory', () {
    test('returns Informational for 1xx', () {
      expect(statusCategory(100), equals('Informational'));
      expect(statusCategory(101), equals('Informational'));
    });

    test('returns Success for 2xx', () {
      expect(statusCategory(200), equals('Success'));
      expect(statusCategory(204), equals('Success'));
    });

    test('returns Redirection for 3xx', () {
      expect(statusCategory(301), equals('Redirection'));
      expect(statusCategory(304), equals('Redirection'));
    });

    test('returns Client Error for 4xx', () {
      expect(statusCategory(400), equals('Client Error'));
      expect(statusCategory(404), equals('Client Error'));
    });

    test('returns Server Error for 5xx', () {
      expect(statusCategory(500), equals('Server Error'));
      expect(statusCategory(503), equals('Server Error'));
    });

    test('returns Unknown for out-of-range codes', () {
      expect(statusCategory(99), equals('Unknown'));
      expect(statusCategory(600), equals('Unknown'));
    });
  });

  group('isSuccess', () {
    test('returns true for 2xx codes', () {
      expect(isSuccess(200), isTrue);
      expect(isSuccess(201), isTrue);
    });

    test('returns false for non-2xx codes', () {
      expect(isSuccess(404), isFalse);
      expect(isSuccess(500), isFalse);
    });
  });

  group('reasonPhrase', () {
    test('returns correct phrase for known codes', () {
      expect(reasonPhrase(200), equals('OK'));
      expect(reasonPhrase(404), equals('Not Found'));
      expect(reasonPhrase(500), equals('Internal Server Error'));
    });

    test('returns Unknown for unrecognized codes', () {
      expect(reasonPhrase(418), equals('Unknown'));
    });
  });
}

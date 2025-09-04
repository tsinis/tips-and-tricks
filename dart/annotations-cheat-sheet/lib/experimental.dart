import 'package:meta/meta.dart';

/// Stable HTTP client for production use.
class HttpClient {
  Future<String> get(String url) async => 'response from $url';
}

/// Preview feature; may break without version bump. Tools can warn when used
/// from external packages that haven't opted into experimental APIs.
@experimental
class Http3Client {
  Future<String> get(String url) async => 'http3 response from $url';
}

/// Simulated external library usage.
class WebFramework {
  static void registerClient(Object client) {
    print('Registered: ${client.runtimeType}');
  }
}

void main() {
  // Stable: safe for production use.
  final stableClient = HttpClient();
  WebFramework.registerClient(stableClient);

  // Experimental: no warning here (same package), but external packages
  // using this would see analyzer warnings unless they opt into experimental APIs.
  final experimentalClient = Http3Client();
  WebFramework.registerClient(experimentalClient);

  print('Both clients registered successfully');
}

import 'package:meta/meta.dart';

/// A restricted supertype: external libraries may implement but may not extend.
interface class ApiService {
  void ping() => print('pong');
}

/// Intentional reopen: suppresses the `implicit_reopen` lint for this subclass.
@reopen
class OpenSubReopened extends ApiService {}

/// LINT: This subclass implicitly reopens [ApiService] for extension outside the
/// library because it lacks a restricting modifier. Triggers `implicit_reopen`.
class OpenSub extends ApiService {}

void main() {
  ApiService a = OpenSub();
  a.ping();

  ApiService b = OpenSubReopened();
  b.ping();
}

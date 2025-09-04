import 'package:meta/meta.dart';

/// Regular helper with an opt-in skip for local runs (safe to commit).
void bench(String name, {bool skip = false}) {
  if (!skip) print('[bench] $name');
}

/// The skip flag is dev-only and should not land in source control.
void spec(String name, {@doNotSubmit bool skip = false}) {
  if (!skip) print('[spec] $name');
}

void main() {
  // Unannotated: allowed to keep skip=true in source (no diagnostic).
  bench('baseline-throughput', skip: true);

  // Annotated: analyzer flags this dev-only toggle to remove before commit.
  spec('wip-scenario', skip: true); // ! invalid_use_of_do_not_submit_member !
}

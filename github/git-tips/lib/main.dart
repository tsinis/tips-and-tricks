/// Returns the category name for an HTTP status code.
String statusCategory(int code) {
  if (code >= 100 && code < 200) return 'Informational';
  if (code >= 200 && code < 300) return 'Success';
  if (code >= 300 && code < 400) return 'Redirection';
  if (code >= 400 && code < 500) return 'Client Error';
  if (code >= 500 && code < 600) return 'Server Error';

  return 'Unknown';
}

/// Returns true if the status code indicates success (2xx).
bool isSuccess(int code) => statusCategory(code) == 'Success';

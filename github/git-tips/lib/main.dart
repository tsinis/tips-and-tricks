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

/// Returns the standard reason phrase for common HTTP status codes.
String reasonPhrase(int code) => switch (code) {
      200 => 'OK',
      201 => 'Created',
      204 => 'No Content',
      301 => 'Moved Permanently',
      304 => 'Not Modified',
      400 => 'Bad Request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not Found',
      500 => 'Internal Server Error',
      502 => 'Bad Gateway',
      503 => 'Service Unavailable',
      _ => 'Unknown',
    };

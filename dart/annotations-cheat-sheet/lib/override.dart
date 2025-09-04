class NotificationService {
  void send(String message) => print('Sending generic notification: $message');
}

class EmailNotificationService extends NotificationService {
  @override // Proper method override, no issues here.
  void send(String message) => print('Sending email: $message');
}

class SmsNotificationService extends NotificationService {
  @override // The method doesn't override an inherited method!
  void sends(String message) => print('Sending SMS: $message');
}

void main() {
  final services = [EmailNotificationService(), SmsNotificationService()];
  for (var service in services) {
    service.send('Your order has shipped!');
  }
  // [SmsNotificationService] will not be able to override the send method,
  // providing only generic notification.
}

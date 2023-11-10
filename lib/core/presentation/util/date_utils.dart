import 'package:intl/intl.dart';

String formatDateTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays == 1) {
    return '1 day ago';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours == 1) {
    return '1 hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes == 1) {
    return '1 minute ago';
  } else {
    return 'Just now';
  }
}

String formatDate(DateTime date) {
  // Define the desired date format
  final dateFormat = DateFormat('dd-M-yyyy');

  // Format the date according to the desired format
  return dateFormat.format(date);
}

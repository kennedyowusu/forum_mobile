String timeAgo(String isoTime) {
  DateTime now = DateTime.now();
  DateTime time = DateTime.parse(isoTime);

  int diffInMinutes = now.difference(time).inMinutes;
  if (diffInMinutes < 60) {
    return '$diffInMinutes minute${diffInMinutes == 1 ? '' : 's'} ago';
  } else if (diffInMinutes < 60 * 24) {
    int diffInHours = (diffInMinutes / 60).floor();
    return '$diffInHours hour${diffInHours == 1 ? '' : 's'} ago';
  } else {
    int diffInDays = (diffInMinutes / (60 * 24)).floor();
    return '$diffInDays day${diffInDays == 1 ? '' : 's'} ago';
  }
}

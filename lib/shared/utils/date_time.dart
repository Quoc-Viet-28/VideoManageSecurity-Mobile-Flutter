String formatTimeString(String timeString) {
  final DateTime now = DateTime.now();
  final DateTime inputDateTime = DateTime.parse(timeString);
  final Duration difference = now.difference(inputDateTime);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} phút trước';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inDays == 1) {
    return 'Hôm qua';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ngày trước';
  } else {
    return inputDateTime.toString().substring(0, 16).replaceAll('T', ' ');
  }
}

String formatDateTimeString(String dateTimeString) {
  // Chuyển đổi chuỗi thành DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Định dạng lại thành chuỗi mới
  String formattedDateTime =
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} ${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';

  return formattedDateTime;
}

String convertDateTimeToString(DateTime dateTime) {
  // Định dạng lại DateTime sang chuỗi mong muốn
  String formattedDate = dateTime.toIso8601String().replaceAll('Z', '');
  return formattedDate;
}

DateTime convertStringToDateTime(String dateString) {
  try {
    // Chuyển đổi chuỗi thành DateTime
    DateTime dateTime = DateTime.parse(dateString);
    return dateTime;
  } catch (e) {
    // Xử lý lỗi nếu chuỗi không hợp lệ
    print('Lỗi khi chuyển đổi chuỗi: $e');
    return DateTime
        .now(); // Hoặc có thể trả về null hoặc một giá trị mặc định khác
  }
}

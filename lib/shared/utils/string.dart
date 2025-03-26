String hideMiddleCharacters(String input) {
  // Kiểm tra độ dài chuỗi
  if (input.length <= 6) {
    return input; // Nếu độ dài nhỏ hơn hoặc bằng 6, không ẩn ký tự
  }

  // Tính toán các phần của chuỗi
  String start = input.substring(0, 4); // 4 ký tự đầu
  String end = input.substring(input.length - 4); // 4 ký tự cuối
  String hidden = 'xxx'; // Ký tự ẩn

  // Kết hợp các phần lại với nhau
  return '$start$hidden$end';
}

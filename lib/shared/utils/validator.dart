class Validator {
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Số điện thoại không được để trống";
    }
    if (!RegExp(r"^(0|\+84)[3|5|7|8|9][0-9]{8}$").hasMatch(value)) {
      return "Định dạng số điện thoại không hợp lệ";
    }
    if (value.length != 10) {
      return "Số điện thoại không hợp lệ";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Không được để trống";
    }
    // if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
    //   return "Email không hợp lệ";
    // }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Không được để trống";
    }
    // if (value.length < 6) {
    //   return "Mật khẩu phải có ít nhất 6 ký tự";
    // }
    return null;
  }

  static String? validateCodePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Mã cá nhân không được để trống";
    }

    if (value.length != 6) {
      return "Mã cá nhân phải có 6 số";
    }
    return null;
  }

  static String? validateContent(String? value) {
    if (value == null || value.isEmpty) {
      return "Vui lòng nhập nội dung";
    }
    return null;
  }
// Bạn có thể thêm nhiều validator khác nếu cần, ví dụ: xác nhận mật khẩu, số điện thoại, tên người dùng, v.v.
}

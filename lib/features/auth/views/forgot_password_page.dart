import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:box_alarm/shared/utils/validator.dart';
import 'package:box_alarm/shared/widgets/share_untils_widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top * 2;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xffd2d2d2).withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          height: availableHeight,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildLogo(),
              const SizedBox(height: 96),
              _buildForm(),
              Spacer(),
              _buildCoppyRight(),
            ],
          ),
        ),
      ),
    ));
  }

  _buildLogo() {
    return SvgPicture.asset('assets/images/auth/logo.svg',
        width: 100, color: Color(0xFF3E3E3E));
  }

  _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('QUÊN MẬT KHẨU'.toUpperCase(),
              style: styleS24W4(Color(0xff007DC0))
                  .copyWith(fontFamily: 'GoodTiming')),
          const SizedBox(height: 32),
          Text(
              'Nhập tên người dùng hoặc địa chỉ email của bạn và chúng tôi sẽ gửi cho bạn hướng dẫn về cách tạo mật khẩu mới.',
              textAlign: TextAlign.center,
              style: styleS16W4(Color(0xff55595D))
                  .copyWith(fontFamily: 'OpenSans')),
          const SizedBox(height: 24),
          TextFieldWidget(
              label: "Tên người dùng hoặc email",
              controller: usernameController,
              validator: Validator.validateEmail),
          const SizedBox(height: 32),
          ButtonWidget(
            title: 'Xác nhận',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Login');
              }
            },
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bạn nhớ lại mật khẩu?',
                style: styleS14W4(Color(0xff363636)),
              ),
              SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Đăng nhập',
                  style: styleS14W5(Color(0xff0088ce)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildCoppyRight() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Text(
          textAlign: TextAlign.center,
          '© 2023 Bản quyền thuộc Oryza JSC. Bảo lưu mọi quyền.',
          style: styleS12W4(Color(0xff55595D)).copyWith(fontFamily: 'Roboto')),
    );
  }
}

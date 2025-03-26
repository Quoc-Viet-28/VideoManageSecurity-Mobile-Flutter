import 'package:box_alarm/shared/constants/shared_constants_export.dart';
import 'package:box_alarm/shared/utils/validator.dart';
import 'package:box_alarm/shared/widgets/share_untils_widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/service/auth_service.dart';
import '../controllers/auth_controller.dart';
import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isRemember = false;

  final AuthController authController = Get.put(
      AuthController(AuthRepository(AuthService()))); // Khởi tạo AuthController

  void login() async {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      try {
        await authController.login(username, password);
        await authController.getInfoUser();
        checkPayLoad();
      } catch (e) {
        // print('Đăng nhập không thành công: ${e.toString()}');
        // Xử lý lỗi đăng nhập (hiển thị thông báo lỗi)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập không thành công')),
        );
      }
    }
  }
  void toggleLoginBtn() async {
    final result = await Auth_Service.instance.login();
    if (result == 'SUCCESS') {
      GoRouter.of(context).go('/home');
    }
  }
  checkPayLoad() {
    if (authController.payload.value.realmAccess!.roles!.contains('SYSTEM')) {
      authController.isAdmin.value = true;
      GoRouter.of(context).go('/home');
    } else {
      authController.isAdmin.value = false;
      GoRouter.of(context).go('/home');
    }
  }

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
          // Sử dụng chiều cao có sẵn
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildLogo(),
              const SizedBox(height: 96),
              // _buildForm(),
              _buildLogin(),
              Spacer(),
              _buildCoppyRight(),
            ],
          ),
        ),
      ),
    ));
  }

  _buildLogo() {
    return SvgPicture.asset('assets/images/auth/LOGO.svg',
        width: 100, color: Color(0xFF3E3E3E));
  }
  _buildLogin(){
    return SizedBox(
      width: double.infinity,
      child: ButtonWidget(
        title: 'Đăng nhập',
        onPressed: () {
          toggleLoginBtn();
        },
      ),
    );
  }

  // _buildForm() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         Text('Đăng nhập'.toUpperCase(),
  //             style: styleS24W4(Color(0xff007DC0))
  //                 .copyWith(fontFamily: 'GoodTiming')),
  //         const SizedBox(height: 32),
  //         TextFieldWidget(
  //             label: "Tên người dùng hoặc email",
  //             controller: usernameController,
  //             validator: Validator.validateEmail),
  //         const SizedBox(height: 16),
  //         TextFieldWidget(
  //             label: "Mật khẩu",
  //             controller: passwordController,
  //             obscure: true,
  //             suffixIcon: true,
  //             validator: Validator.validatePassword),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Transform.translate(
  //               offset: const Offset(-16, 0),
  //               child: RadioCheckboxWidget(
  //                 title: 'Nhớ mật khẩu',
  //                 isChecked: isRemember,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     isRemember = value!;
  //                   });
  //                 },
  //               ),
  //             ),
  //             InkWell(
  //               borderRadius: BorderRadius.circular(16),
  //               onTap: () {
  //                 GoRouter.of(context).go('/forgot-password');
  //               },
  //               child: Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   'Quên mật khẩu?',
  //                   style: styleS14W5(Color(0xff007DC0)),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 32),
  //         Obx(() {
  //           return authController.isLoading.value
  //               ? SizedBox(
  //                   width: double.infinity,
  //                   child: ButtonWidget(
  //                     onPressed: () {},
  //                   ),
  //                 )
  //               : Container(
  //                   width: double.infinity,
  //                   child: ButtonWidget(
  //                     title: 'Đăng nhập',
  //                     onPressed: () {
  //                       toggleLoginBtn();
  //                     },
  //                   ),
  //                 );
  //         }),
  //       ],
  //     ),
  //   );
  // }
  //

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

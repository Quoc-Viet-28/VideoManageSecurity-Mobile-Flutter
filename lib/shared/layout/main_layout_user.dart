import 'package:box_alarm/features/auth/controllers/auth_controller.dart';
import 'package:box_alarm/shared/constants/app_colors.dart';
import 'package:box_alarm/shared/constants/app_styles.dart';
import 'package:box_alarm/shared/layout/interface/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constants/select_menu.dart';

class MainLayoutUser extends StatefulWidget {
  const MainLayoutUser({super.key, required this.child});

  final Widget child;

  @override
  State<MainLayoutUser> createState() => _MainLayoutUserState();
}

class _MainLayoutUserState extends State<MainLayoutUser> {
  late ItemDrawer selectedItem;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    selectedItem = selectedItemDrawerUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
        body: widget.child,
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: darkSteelGray,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            color: lightSilverGray,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      centerTitle: true,
      title: SvgPicture.asset('assets/images/home/logo.svg'),
      actions: [
        Container(
          height: 44,
          width: 44,
          margin: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://github.com/github.png?size=460'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  _buildDrawer() {
    return Container(
      color: darkSteelGray,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Column(
              children: [
                _buildDrawerHeader(),
                // _buildDrawerContent(),
                Spacer(),
                _buildDrawerFooter(),
              ],
            ),
            Positioned(
              left: -16,
              top: -6,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: lightSilverGray)),
            ),
          ],
        ),
      ),
    );
  }

  _buildDrawerHeader() {
    return Obx(
      () {
        return Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/images/home/logo.svg',
                    height: 38, width: 38)),
            SizedBox(height: 16),
            Divider(color: neutralGray),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                // setState(() {
                //   selectedItemDrawerUser = ItemDrawer(
                //       icon: 'item_drawer_1.svg', title: 'N/A', route: '/N/A');
                // });
                // Navigator.pop(context);
                // GoRouter.of(context).go('/profile');
              },
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://github.com/github.png?size=460'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authController.infoUser.value.lastName ?? 'N/A',
                          style: styleS18W4(Colors.white)),
                      Text(authController.infoUser.value.email ?? 'N/A',
                          style: styleS14W4(Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: neutralGray),
          ],
        );
      },
    );
  }

  _buildDrawerContent() {
    return Column(children: [
      ...drawersUser.map((item) => _buildItemDrawer(item)),
    ]);
  }

  _buildItemDrawer(ItemDrawer item) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          selectedItemDrawerUser = item;
        });
        GoRouter.of(context).go(item.route);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: 59,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: selectedItem == item ? oceanBlue : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/home/${item.icon}',
                height: 20, width: 20),
            SizedBox(width: 12),
            Text(item.title, style: styleS18W4(Colors.white)),
          ],
        ),
      ),
    );
  }

  _buildDrawerFooter() {
    return Column(
      children: [
        Divider(color: neutralGray),
        InkWell(
          onTap: () {
            authController.logout();
            GoRouter.of(context).go('/');
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 59,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/home/item_drawer_9.svg',
                    height: 20, width: 20),
                SizedBox(width: 12),
                Text('Đăng xuất', style: styleS18W4(Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:box_alarm/features/auth/controllers/auth_controller.dart';
import 'package:box_alarm/shared/constants/app_colors.dart';
import 'package:box_alarm/shared/constants/app_styles.dart';
import 'package:box_alarm/shared/layout/interface/item_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../constants/select_menu.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late ItemDrawer selectedItem;

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = selectedItemDrawerAdmin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(),
        body: Scaffold(body: widget.child, backgroundColor: const Color(0xFF171C1F)),
      ),
    );
  }
  _buildAppBar() {
    return AppBar(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFF111518),
          width: 1,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      toolbarHeight: 80,
      backgroundColor: const Color(0xFF171C1F),
      titleSpacing: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Image.asset(
            'assets/images/logo/Menu_bar.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: const Text(
                'Oryza Metadata',
                style: TextStyle(
                  color: Color(0xFF4E6A78),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  _buildDrawer() {
    return Container(
      color: darkSteelGray,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Column(
              children: [
                _buildDrawerHeader(),
                // _buildDrawerContent(),
                const Spacer(),
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
            const SizedBox(height: 16),
            Divider(color: neutralGray),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                // setState(() {
                //   selectedItemDrawerAdmin = ItemDrawer(
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
                  const SizedBox(width: 16),
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
            const SizedBox(height: 16),
            Divider(color: neutralGray),
          ],
        );
      },
    );
  }

  _buildDrawerContent() {
    return Column(children: [
      ...drawersAdmin.map((item) => _buildItemDrawer(item)),
    ]);
  }

  _buildItemDrawer(ItemDrawer item) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          selectedItemDrawerAdmin = item;
        });
        Navigator.pop(context);
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/home/${item.icon}',
                height: 20, width: 20),
            const SizedBox(width: 12),
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/home/item_drawer_9.svg',
                    height: 20, width: 20),
                const SizedBox(width: 12),
                Text('Đăng xuất', style: styleS18W4(Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

}

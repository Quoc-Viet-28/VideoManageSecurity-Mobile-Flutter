import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class ListServer extends StatelessWidget {
  final String name;
  final String ip;
  final String username;
  const ListServer({super.key, required this.name, required this.ip, this.username=''});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('Connect to $name');
        GoRouter.of(context).go('/camera');
      },
      child: Container(
        color: const Color(0xFF212A2F),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn đều
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Inter', fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo/Edit.png',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo/Server.png',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      ip,
                      style: const TextStyle(color: Color(0xFFA5B7C1), fontWeight: FontWeight.w400, fontFamily: 'Inter', fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo/User.png',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      username,
                      style: const TextStyle(color: Color(0xFFA5B7C1), fontWeight: FontWeight.w400, fontFamily: 'Inter', fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

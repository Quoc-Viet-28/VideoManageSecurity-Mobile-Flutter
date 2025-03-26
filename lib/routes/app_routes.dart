import 'package:box_alarm/features/auth/views/auth_views_export.dart';
import 'package:box_alarm/features/home/views/home_views_export.dart';
import 'package:go_router/go_router.dart';

import '../features/camera/live_view_page.dart';

final GoRouter goRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => LoginPage()),
  GoRoute(path: '/forgot-password', builder: (context, state) => ForgotPasswordPage()),
  GoRoute(path: '/home', builder: (context, state) => HomePage()),
  GoRoute(path: '/camera', builder: (context, state) => LiveViewPage()),
]);

import 'package:go_router/go_router.dart';
import 'package:kowri/screens/chat-page.dart';
import 'package:kowri/screens/all-tasks/create-task.dart';
import 'package:kowri/screens/all-tasks/edit-task.dart';
import 'package:kowri/screens/all-tasks/update-delete-task.dart';
import 'package:kowri/screens/all-tasks/view-detail.dart';
import 'package:kowri/screens/all-tasks/view-task.dart';
import 'package:kowri/screens/home.dart';
import 'package:kowri/screens/registration/complete_registration.dart';
import 'package:kowri/screens/registration/login.dart';
import 'package:kowri/screens/registration/register.dart';
import 'package:kowri/screens/settings.dart';
import 'package:kowri/screens/splash_screen.dart';

final GoRouter router = GoRouter(initialLocation: "/splash_screen", routes: [
  //User Page
  GoRoute(path: '/splash_screen', builder: (context, state) => SplashScreen()),
  GoRoute(path: '/login', builder: (context, state) => LoginPage()),
  GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
  GoRoute(path: '/completed_registration', builder: (context, state) => CompleteRegistration()),
  GoRoute(path: '/home', builder: (context, state) => HomePage()),
  GoRoute(path: '/settings', builder: (context, state) => Settings()),
  GoRoute(path: '/create-task', builder: (context, state) => CreateTasks()),
  GoRoute(path: '/view-tasks', builder: (context, state) => ViewTasks()),
  GoRoute(
    path: '/view-detail/:taskId',
    builder: (context, state) {
      final taskId = state.pathParameters['taskId']!;
      return ViewDetail(taskId: taskId);
    },
  ),
    GoRoute(
    path: '/edit-task/:taskId',
    builder: (context, state) {
      final taskId = state.pathParameters['taskId']!;
      return EditTask(taskId: taskId);
    },
  ),
  GoRoute(path: '/update-delete-task', builder: (context, state) => UpdateAndDeleteTasks()),
    GoRoute(path: '/chat-page', builder: (context, state) => ChatPage()),
]);

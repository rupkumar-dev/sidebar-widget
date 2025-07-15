import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Admin/admin.dart';
import 'route_name.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.dashboard,
    errorBuilder: (context, state) => Center(
      child: Text('error'),
    ),
    routes: [
      // Login route outside admin shell
      GoRoute(
        name: RouteNames.login,
        path: '/login',
        builder: (context, state) => const Center(
          child: Text('Login'),
        ),
      ),
      // Admin shell route containing protected routes
      ShellRoute(
        builder: (context, state, child) => Dashboard(
          child: child,
        ),
        routes: [
          _dashboardRoute,
          _studentRoute,
          _classesRoute,
          _teachersRoute,
          _settingsRoute,
          _parentsRoute,
          _userRoute,
        ],
      ),
    ],
  );

  static final _dashboardRoute = GoRoute(
      name: RouteNames.dashboard,
      path: '/dashboard',
      builder: (context, state) => Center(
            child: Text('Dashboard'),
          ));

  static final _studentRoute = GoRoute(
    name: RouteNames.students,
    path: '/students',
    builder: (context, state) => Center(
      child: Text('Student'),
    ),
    routes: [
      GoRoute(
        name: RouteNames.studentList,
        path: 'student-list',
        builder: (context, state) => Center(
          child: Text('Student List'),
        ),
      ),
      GoRoute(
        name: RouteNames.exams,
        path: 'exams',
        builder: (context, state) => Center(
          child: Text('Exams'),
        ),
      ),
      GoRoute(
        name: RouteNames.attendance,
        path: 'attendance',
        builder: (context, state) => Center(
          child: Text('Attendance'),
        ),
      ),
      GoRoute(
        name: RouteNames.marks,
        path: 'marks',
        builder: (context, state) => Center(
          child: Text('Marks'),
        ),
      ),
      GoRoute(
        name: RouteNames.results,
        path: 'results',
        builder: (context, state) => Center(
          child: Text('Results'),
        ),
      ),
    ],
  );

  static final _teachersRoute = GoRoute(
    name: RouteNames.teachers,
    path: '/teachers',
    builder: (context, state) => Center(
      child: Text('Teacher'),
    ),
    routes: [
      GoRoute(
        name: RouteNames.teachersList,
        path: 'teachers-list',
        builder: (context, state) => Center(
          child: Text('Teachers List'),
        ),
      ),
      GoRoute(
        name: RouteNames.teacherAttendance,
        path: 'teacher-attendance',
        builder: (context, state) => Center(
          child: Text('Teacher Attendance'),
        ),
      ),
    ],
  );
  static final _parentsRoute = GoRoute(
    name: RouteNames.parents,
    path: '/parents',
    builder: (context, state) => Center(
      child: Text('Parents'),
    ),
    routes: [
      GoRoute(
        name: RouteNames.parentsList,
        path: 'parents-list',
        builder: (context, state) => Center(
          child: Text('Parents List'),
        ),
      ),
    ],
  );
  static final _classesRoute = GoRoute(
      name: RouteNames.classes,
      path: '/classes',
      builder: (context, state) => Center(
            child: Text('Class'),
          ));

  static final _userRoute = GoRoute(
      name: RouteNames.user,
      path: '/user',
      builder: (context, state) => Center(
            child: Text('User'),
          ),
      routes: [
        GoRoute(
          name: RouteNames.profile,
          path: 'profile',
          builder: (context, state) => Center(
            child: Text('Profile'),
          ),
        ),
        GoRoute(
          name: RouteNames.changePassword,
          path: 'change-password',
          builder: (context, state) => Center(
            child: Text('Change Password'),
          ),
        ),
        GoRoute(
          name: RouteNames.email,
          path: 'email',
          builder: (context, state) => Center(
            child: Text('Email'),
          ),
        ),
        GoRoute(
          name: RouteNames.phone,
          path: 'phone',
          builder: (context, state) => Center(
            child: Text('Phone'),
          ),
        ),
        GoRoute(
          name: RouteNames.address,
          path: 'address',
          builder: (context, state) => Center(
            child: Text('Address'),
          ),
        ),
        GoRoute(
          name: RouteNames.logout,
          path: 'logout',
          builder: (context, state) => Center(
            child: Text('Logout'),
          ),
        ),
      ]);

  static final _settingsRoute = GoRoute(
      name: RouteNames.settings,
      path: '/settings',
      builder: (context, state) => Center(
            child: Text('Setting'),
          ));
}

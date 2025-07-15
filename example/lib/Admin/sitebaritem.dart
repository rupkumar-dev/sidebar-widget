import 'package:flutter/material.dart';
import 'package:sidebar_widget/sidebar_widget.dart';
import '../Routes/route_name.dart';

final List<dynamic> items = [
  NavigationItem(
    title: 'Dashboard',
    icon: Icons.dashboard,
    route: RouteNames.dashboard,
  ),
  Divider(),
  NavigationItem(
    title: 'Students',
    icon: Icons.school,
    route: RouteNames.students,
    subItems: [
      Subitem(title: 'Students List', route: RouteNames.studentList),
      Subitem(title: 'Exams', icon: Icons.assignment, route: RouteNames.exams),
      Subitem(
          title: 'Attendance',
          icon: Icons.calendar_today,
          route: RouteNames.attendance),
      Subitem(title: 'Marks', route: RouteNames.marks),
      Subitem(title: 'Results', route: RouteNames.results),
    ],
  ),
  NavigationItem(
    title: 'Teachers',
    icon: Icons.person,
    subItems: [
      Subitem(title: 'Teachers List', route: RouteNames.teachersList),
      Subitem(
          title: 'Teacher Attendance',
          icon: Icons.calendar_today,
          route: RouteNames.teacherAttendance),
    ],
  ),
  NavigationItem(
    title: 'Parents',
    icon: Icons.people,
    subItems: [
      Subitem(
          title: 'Parents List',
          icon: Icons.people,
          route: RouteNames.parentsList),
    ],
  ),
  NavigationItem(
    title: 'Classes',
    icon: Icons.settings,
    route: RouteNames.classes,
  ),
  NavigationItem(
    title: 'Settings',
    icon: Icons.settings,
    route: RouteNames.settings,
  ),
  NavigationItem(
    title: 'User',
    icon: Icons.school,
    route: RouteNames.user,
    subItems: [
      Subitem(title: 'Profile', route: RouteNames.profile),
      Subitem(title: 'Change Password', route: RouteNames.changePassword),
      Subitem(title: 'Email', route: RouteNames.email),
      Subitem(title: 'Phone', route: RouteNames.phone),
      Subitem(title: 'Address', route: RouteNames.address),
      Subitem(title: 'Logout', route: RouteNames.logout),
    ],
  ),
];

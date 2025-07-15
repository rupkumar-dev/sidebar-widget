import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:sidebar_widget/sidebar_widget.dart';
import 'package:provider/provider.dart';
import 'sitebaritem.dart';

class DashboardController extends ChangeNotifier {
  bool isDrawerOpen = true;

  void toggle() {
    isDrawerOpen = !isDrawerOpen;
    notifyListeners();
  }
}

class Dashboard extends StatelessWidget {
  final Widget child;
  // Move the GlobalKey to be a class field
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Dashboard({super.key, required this.child});

  @override
  Widget build(
    BuildContext context,
  ) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return ChangeNotifierProvider(
      create: (_) => DashboardController(),
      child: Consumer<DashboardController>(builder: (context, controller, _) {
        return Scaffold(
          key: scaffoldKey,
          drawer: isMobile ? const Sidebar() : null,
          body: Row(
            children: [
              if (!isMobile && controller.isDrawerOpen) const Sidebar(),
              Expanded(
                child: Column(
                  children: [
                    AppBar(
                      title: const Text('Dashboard'),
                      leading: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          if (MediaQuery.of(context).size.width < 600) {
                            scaffoldKey.currentState?.openDrawer();
                          } else {
                            controller.toggle();
                          }
                        },
                      ),
                    ),
                    Expanded(child: child), // Wrap child with Expanded
                  ],
                ),
              ),
              // Remove duplicate child here
            ],
          ),
        );
      }),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;
    return CustomSideBar(
      currentRoute: path,
      items: items,
      backgroundColor: Colors.black87,
      width: 250,
      onRouteSelected: (route) {
        context.goNamed(route);
      },
    );
  }
}

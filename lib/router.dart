import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_flutter/pages/done_todo_list_page.dart';
import 'package:todo_app_flutter/pages/todo_list_page.dart';
import 'package:todo_app_flutter/type/bottom_tab_type.dart';
import 'package:todo_app_flutter/widgets/scaffold_with_navigation_bar.dart';

// NavigationBarを表示させるページに指定するkey
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
// NavigationBarを表示させないページに指定するkey
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider(
      (ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: BottomTabType.todoList.path,
      routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, __, child) => ScaffoldWithNavigationBar(child: child),
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: BottomTabType.todoList.path,
            pageBuilder: (_, __) =>
            const NoTransitionPage(child: TodoListPage()),
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: BottomTabType.doneTodoList.path,
            pageBuilder: (_, __) =>
            const NoTransitionPage(child: DoneTodoListPage()),
          )
        ]
      )
      ],
    );
  }
);
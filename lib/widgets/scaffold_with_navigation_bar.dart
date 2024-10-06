import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_flutter/type/bottom_tab_type.dart';

class ScaffoldWithNavigationBar extends HookConsumerWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTabType = useState<BottomTabType>(BottomTabType.values.first);

    void onItemTapped(BottomTabType tabType, BuildContext context) {
        GoRouter.of(context).go(tabType.path);
        currentTabType.value = tabType;
    }

    return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: BottomTabType.values.indexOf(currentTabType.value),
          onDestinationSelected: (int index) => onItemTapped(
              BottomTabType.values[index],
              context
          ),
          destinations: BottomTabType.values.map((tabType){
              return NavigationDestination(
                label: tabType.name,
                icon: Icon(tabType.icon),
              );
          }).toList()
        ),
    );
  }
}
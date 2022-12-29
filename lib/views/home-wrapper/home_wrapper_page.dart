import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outclass/views/core/app_router.dart';

enum HomeSection { overview, calendar, directories, account }

enum NavigationType { bottom, rail, drawer }

class AdaptiveScaffoldDestination {
  const AdaptiveScaffoldDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key});

  List<AdaptiveScaffoldDestination> _getDestinations(BuildContext context) {
    return HomeSection.values.map((section) {
      switch (section) {
        case HomeSection.overview:
          return const AdaptiveScaffoldDestination(
            icon: MdiIcons.homeVariantOutline,
            selectedIcon: Icons.home_filled,
            label: 'Beranda',
          );
        case HomeSection.calendar:
          return const AdaptiveScaffoldDestination(
            icon: Icons.calendar_today_outlined,
            selectedIcon: Icons.calendar_today_rounded,
            label: 'Kalender',
          );
        case HomeSection.directories:
          return const AdaptiveScaffoldDestination(
            icon: Icons.folder_open_rounded,
            selectedIcon: Icons.folder_rounded,
            label: 'Berkas',
          );
        case HomeSection.account:
          return const AdaptiveScaffoldDestination(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: 'Profil',
          );
      }
    }).toList();
  }

  void _onNavigationChanged(BuildContext context, int index) {
    final tabsRouter = AutoTabsRouter.of(context);
    if (index != tabsRouter.activeIndex) {
      tabsRouter.setActiveIndex(index);
    } else {
      tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final destinations = _getDestinations(context);

    final NavigationType navigationType;
    if (data.size.width < 600) {
      if (data.orientation == Orientation.portrait) {
        navigationType = NavigationType.bottom;
      } else {
        navigationType = NavigationType.rail;
      }
    } else if (data.size.width < 1024) {
      navigationType = NavigationType.rail;
    } else {
      navigationType = NavigationType.drawer;
    }

    return AutoTabsRouter(
      duration: const Duration(milliseconds: 300),
      lazyLoad: true,
      curve: Curves.easeIn,
      routes: HomeSection.values.map((section) {
        switch (section) {
          case HomeSection.overview:
            return const OverviewRoute();
          case HomeSection.calendar:
            return const CalendarRoute();
          case HomeSection.directories:
            return const DirectoriesTabWrapperRoute();
          case HomeSection.account:
            return const AccountWrapperRoute();
        }
      }).toList(),
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return WillPopScope(
          onWillPop: () async {
            if (tabsRouter.activeIndex != 0) {
              tabsRouter.setActiveIndex(0);
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            bottomNavigationBar: navigationType == NavigationType.bottom
                ? NavigationBar(
                    selectedIndex: tabsRouter.activeIndex,
                    onDestinationSelected: (index) =>
                        _onNavigationChanged(context, index),
                    destinations: destinations
                        .map(
                          (destination) => NavigationDestination(
                            label: destination.label,
                            icon: Icon(destination.icon),
                            selectedIcon: Icon(destination.selectedIcon),
                          ),
                        )
                        .toList(),
                  )
                : null,
            body: Row(
              children: [
                if (navigationType != NavigationType.bottom) ...[
                  _HomeNavigationRail(
                    extended: navigationType == NavigationType.drawer,
                    destinations: destinations,
                    selectedIndex: tabsRouter.activeIndex,
                    onDestinationSelected: (index) =>
                        _onNavigationChanged(context, index),
                  ),
                  const VerticalDivider(width: 1, thickness: 0.2),
                ],
                Expanded(
                  child: FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: ReverseAnimation(animation),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HomeNavigationRail extends StatelessWidget {
  const _HomeNavigationRail({
    required this.extended,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final bool extended;
  final int selectedIndex;
  final void Function(int index) onDestinationSelected;
  final List<AdaptiveScaffoldDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      selectedIndex: selectedIndex,
      leading: SizedBox(
        height: MediaQuery.of(context).padding.top,
      ),
      labelType:
          extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations
          .map(
            (destination) => NavigationRailDestination(
              label: Text(destination.label),
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
            ),
          )
          .toList(),
    );
  }
}

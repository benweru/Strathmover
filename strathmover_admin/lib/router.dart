import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_route_page.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_trip_page.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/dashboard_page.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/routes.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/trips.dart';
import 'package:flutter_admin_dashboard_template/features/users/dummy_users.dart';
import 'package:flutter_admin_dashboard_template/features/users/user_not_found_page.dart';
import 'package:flutter_admin_dashboard_template/features/users/user_page.dart';
import 'package:flutter_admin_dashboard_template/features/users/users_page.dart';
import 'package:flutter_admin_dashboard_template/models/route_model.dart';
import 'package:flutter_admin_dashboard_template/models/trip_model.dart';
import 'package:flutter_admin_dashboard_template/widgets/navigation/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

const routerInitialLocation = '/';

final router = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
  initialLocation: routerInitialLocation,
);

@TypedStatefulShellRoute<ShellRouteData>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DashboardRoute>(
          path: routerInitialLocation,
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<TripsRoute>(
          path: '/trips',
          routes: [
            TypedGoRoute<EditTripRoute>(
              path: ':tripId/edit',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<RoutesRoute>(
          path: '/routes',
          routes: [
            TypedGoRoute<EditRouteRoute>(
              path: ':routeId/edit',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<UsersPageRoute>(
          path: '/users',
          routes: [
            TypedGoRoute<UserPageRoute>(
              path: ':userId',
            ),
          ],
        ),
      ],
    ),
  ],
)
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return SelectionArea(
      child: ScaffoldWithNavigation(
        navigationShell: navigationShell,
      ),
    );
  }
}

class DashboardRoute extends GoRouteData {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashBoardPage();
  }
}

class TripsRoute extends GoRouteData {
  const TripsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TripsPage();
  }
}

class EditTripRoute extends GoRouteData {
  const EditTripRoute({required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final trip = state.extra as TripModel;
    return EditTripPage(trip: trip);
  }
}

class RoutesRoute extends GoRouteData {
  const RoutesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RoutesPage();
  }
}

class EditRouteRoute extends GoRouteData {
  const EditRouteRoute({required this.routeId});

  final String routeId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final route = state.extra as RouteModel;
    return EditRoutePage(route: route);
  }
}

class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersPage();
  }
}

class UserPageRoute extends GoRouteData {
  const UserPageRoute({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = dummyUsers.firstWhereOrNull((e) => e.userId == userId);
    return user == null
        ? UserNotFoundPage(userId: userId)
        : UserPage(user: user);
  }
}

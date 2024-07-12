import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_booking_page.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_route_page.dart';
import 'package:flutter_admin_dashboard_template/features/crud/edit_trip_page.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/bookings.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/dashboard_page.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/routes.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/trips.dart';
import 'package:flutter_admin_dashboard_template/features/dashboard/users.dart';
import 'package:flutter_admin_dashboard_template/models/bookings_model.dart';
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
        TypedGoRoute<BookingsPageRoute>(
          path: '/bookings',
          routes: [
            TypedGoRoute<BookingPageRoute>(
              path: ':bookingId',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<UsersPageRoute>(
          path: '/users',
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
    return DashboardPage();
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

class BookingsPageRoute extends GoRouteData {
  const BookingsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BookingsPage();
  }
}

class BookingPageRoute extends GoRouteData {
  const BookingPageRoute({required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final booking = state.extra as Booking;
    return EditBookingPage(booking: booking);
  }
}

class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    print('Building UsersPage');
    return UsersPage();
  }
}

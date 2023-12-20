import 'package:flutter/material.dart';

/// This is created to get a Global reference to the context, so that we are able to
/// navigate from anywhere inside the app by using the navigator key from here.
///
/// Please read more about the NavigatorState to know why a global key is required
/// for the way we have used in this app.

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}
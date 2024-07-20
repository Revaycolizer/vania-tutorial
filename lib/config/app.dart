import 'package:vania/vania.dart';
import 'package:todo/app/providers/route_service_povider.dart';

import 'auth.dart';
import 'cors.dart';

// TimeZoneSettings africaTimeZone = TimeZoneSettings(
//   name: 'Africa',
//   // Other timezone settings if required by your package
// );

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  // 'timezone': 'Africa',
  'cors': cors,
  'auth': authConfig,
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
  ],
};

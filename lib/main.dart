import 'dart:async';

import 'package:chatapp/Core/Logger/console_dispatcher.dart';
import 'package:chatapp/Core/Logger/file_logger_dispatcher.dart';
import 'package:chatapp/Core/Logger/loggable.dart';
import 'package:chatapp/Core/Logger/logger_service.dart';
import 'package:chatapp/Core/Logger/logs_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final logFilePath = await _setupLogger();

      _installGlobalErrorListeners();
      runApp(MyApp(logFilePath: logFilePath));
}

void _installGlobalErrorListeners() {
  FlutterError.onError = (FlutterErrorDetails details) {
    unawaited(LoggerService.to.logUnhandledError(
      details.exception,
      details.stack ?? StackTrace.current,
      source: 'FlutterError.onError',
    ));

  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    unawaited(LoggerService.to.logUnhandledError(
      error,
      stackTrace,
      source: 'PlatformDispatcher.onError',
    ));
    return true;
  };
}




Future<String> _setupLogger() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final logFilePath = '${documentsDirectory.path}/chatapp.log';

  final logger = LoggerService();
  await logger.init(
    [
      ConsoleDispatcher(),
      FileLoggerDispatcher(logFilePath: logFilePath),
    ],
    [WrapperExtension.addWrappers],
    minLevel: LogLevel.debug,
    rateLimiter: RateLimiter(maxRate: 100, timeWindow: const Duration(seconds: 10)),
  );

  Get.put<LoggerService>(logger, permanent: true);
  await logger.log(
    'Logger initialized',
    level: LogLevel.info,
  );

  return logFilePath;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.logFilePath});

  final String logFilePath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapSample(logFilePath: logFilePath),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key, required this.logFilePath});

  final String logFilePath;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> with Loggable {
  static const LatLng _markerOnePosition = LatLng(
    31.9516,
    35.9348,
  );
  static const LatLng _markerTwoPosition = LatLng(
    31.9632,
    35.9106,
  );
  static const LatLng _customMarkerPosition = LatLng(31.9497, 35.9230);
  static const PolylineId _shortestPathId = PolylineId('shortest_path');

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<AdvancedMarker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _loadMarkers();
    unawaited(info('Map screen initialized', tags: ['map', 'startup']));
  }

  void _loadMarkers() {
    [
      AdvancedMarker(
        markerId: const MarkerId('marker_1'),
        position: _markerOnePosition,
        infoWindow: const InfoWindow(title: 'Roman Theater'),
      ),
      AdvancedMarker( 
        markerId: const MarkerId('marker_2'),
        position: _markerTwoPosition,
        infoWindow: const InfoWindow(title: 'Abdali Boulevard'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
      AdvancedMarker(
        markerId: const MarkerId('custom_marker'),
        position: _customMarkerPosition,
        infoWindow: const InfoWindow(title: 'Rainbow Street'),
        icon: BitmapDescriptor.pinConfig(
          glyph: const TextGlyph(text: 'A', textColor: Colors.white),
          borderColor: Colors.red,
          backgroundColor: Colors.blue,
        ),
      ),
    ].forEach(_markers.add);
    setState(() {});
    unawaited(debug('Loaded ${_markers.length} markers', tags: ['map', 'markers']));
  }

  void _loadShortestPath() async {
    final List<LatLng> shortestPathPoints = 
     [ _markerOnePosition,
      _markerTwoPosition,
    ];

    _polylines.add(
      Polyline(
        polylineId: _shortestPathId,
        points: shortestPathPoints,
        color: Colors.blue,
        width: 5,
        geodesic: true,
      ),
    );
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: _markerOnePosition,
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapId: "DEMO_MAP_ID",
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Logger ready',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.logFilePath,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton(
                            onPressed: _writeTestLogs,
                            child: const Text('Write test logs'),
                          ),
                          FilledButton.tonal(
                            onPressed: _throwValidationError,
                            child: const Text('Throw validation'),
                          ),
                          FilledButton.tonal(
                            onPressed: _throwAuthorizationError,
                            child: const Text('Throw authorization'),
                          ),
                          FilledButton.tonal(
                            onPressed: _throwAsyncNetworkError,
                            child: const Text('Throw async network'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    _loadShortestPath();
    setState(() {});
    await info('Shortest path rendered on the map', tags: ['map', 'polyline']);
  }

  Future<void> _writeTestLogs() async {
    await debug('Debug test log from map sample', tags: ['test', 'map']);
    await info('Info test log from map sample', tags: ['test', 'map']);
    await warning('Warning test log from map sample', tags: ['test', 'map']);
    await error('Error test log from map sample', tags: ['test', 'map']);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wrote test logs to console and file')),
    );
  }

  void _throwValidationError() {
    throw ArgumentError('Selected destination is invalid.');
  }

  void _throwAuthorizationError() {
    throw StateError('You are not allowed to access the protected route.');
  }

  void _throwAsyncNetworkError() {
    Future<void>.delayed(const Duration(milliseconds: 10), () {
      throw Exception('Unable to fetch map tiles from the server.');
    });
  }
}

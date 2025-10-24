import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:visual_algo/app.dart';
import 'package:visual_algo/firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_web/firebase_storage_web.dart'; 
import 'package:firebase_storage_platform_interface/firebase_storage_platform_interface.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureSystemChrome();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    Firebase.app();
  }
  if (kIsWeb) {
    FirebaseStoragePlatform.instance = FirebaseStorageWeb(bucket: 'algorithmat-615cf.appspot.com');
  }
  FirebaseStorage.instance; 
  if (kDebugMode) {
    FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
    debugPrint('Connected to Firebase Functions emulator on port 5001 ✅');
  }

  runApp(const ProviderScope(child: AlgorithMatApp()));
}

Future<void> _configureSystemChrome() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

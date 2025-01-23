

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/Navigation_footer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart' as provider;
import './models/settings_model.dart';
import './auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBRWMSrAj0YI1majFBey9v0If6ce98sA2c",
            authDomain: "subscription-management-afb26.firebaseapp.com",
            projectId: "subscription-management-afb26",
            storageBucket: "subscription-management-afb26.firebasestorage.app",
            messagingSenderId: "861362040228",
            appId: "1:861362040228:web:a9ab7f152ad0258daaa531",
            measurementId: "G-QL0X9TMEKF"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    ProviderScope(
      child: provider.ChangeNotifierProvider(
        create: (context) => SettingsModel(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return provider.Consumer<SettingsModel>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: settings.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error: ${snapshot.error}')),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasData && snapshot.data != null) {
                print('User is logged in');
                return const HomeView(); // User is logged in
              } else {
                print('User is not logged in');
                return const LogInPage(); // User is not logged in
              }
            },
          ),
        );
      },
    );
  }
}


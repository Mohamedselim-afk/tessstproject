import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/api_service.dart';
import 'bloc/login_bloc.dart';
import 'screens/login_screen.dart';
import 'services/notification_service.dart';
import 'services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyDOU2qpIRznhayAoME155JKqC7RfIKtCVU",
      authDomain: "tessstprojectl.firebaseapp.com",
      projectId: "tessstprojectl",
      storageBucket: "tessstprojectl.firebasestorage.app",
      messagingSenderId: "477382677669",
      appId: "1:477382677669:web:260b98df462a8110f9a94c",
      measurementId: "G-X3D8XQEQBQ"
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login with Notifications and Location',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(
              ApiService(),
              NotificationService(),
              LocationService(),
            ),
          ),
        ],
        child: LoginScreen(),
      ),
    );
  }
}

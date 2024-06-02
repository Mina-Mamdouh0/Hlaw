import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/firebase_options.dart';
import 'package:hlaw/screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(  MultiBlocProvider(
    providers: [
      BlocProvider (create: (BuildContext context) => AppCubit(),),
    ],
    child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HLAW',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


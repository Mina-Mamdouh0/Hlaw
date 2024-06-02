
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/screen/auth/login_screen.dart';
import 'package:hlaw/screen/auth/select_login_screen.dart';
import 'package:hlaw/screen/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    BlocProvider.of<AppCubit>(context).getProfileData();

    Timer(const Duration(seconds: 3),
            () async{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return FirebaseAuth.instance.currentUser?.uid == null ?  const SelectLoginScreen():const LayoutScreen();
          }));
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF822929),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}

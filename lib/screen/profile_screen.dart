
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/bloc/app_state.dart';
import 'package:hlaw/screen/auth/select_login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: const Center(
                      child: Text('Profile',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            fontFamily: 'KantumruyPro'
                        ),),
                    ),

                  ),
                ),

                Row(
                  children: [
                    const Expanded(
                      child: Text('Email : ',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(cubit.profileModel?.email??'',
                        style: const TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Full Name : ',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(cubit.profileModel?.userName??'',
                        style: const TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Password : ',
                        style: TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                        ),),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: Text(cubit.profileModel?.password??'',
                        style: const TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),



                InkWell(
                  onTap: (){
                    cubit.logout();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color:  const Color(0XFF822929),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.center),
                  ),
                ),

              ],
            ),
          );
        },
        listener: (context,state){
          if(state is LogoutState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return const SelectLoginScreen();
            }), (route) => false);
          }
        },
      )

    );
  }
}

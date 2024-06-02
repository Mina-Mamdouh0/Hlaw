
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hlaw/screen/auth/login_screen.dart';
import 'package:hlaw/screen/auth/register_screen.dart';

class SelectLoginScreen extends StatelessWidget {
  const SelectLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF0EAEA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/topLogin.png',width: double.infinity,),
          const SizedBox(height: 30,),
          Center(
            child: SizedBox(
              height: 150,
                width: 150,
                child: Image.asset('assets/images/logo2.png',width: double.infinity,)),
          ),
          const SizedBox(height: 20,),
          const Center(
            child: Text('Video chat \napplication',style: TextStyle(
              color: Colors.black,
              fontFamily:'KantumruyPro',
              fontWeight: FontWeight.w700,
              fontSize: 25
            ),textAlign: TextAlign.center,),
          ),
          const Spacer(),

          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  LoginScreen();
              }));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black,
                )
              ),
              child: const Text('Login',style: TextStyle(
                  color: Colors.black,
                  fontFamily:'KantumruyPro',
                  fontWeight: FontWeight.w700,
                  fontSize: 32
              ),textAlign: TextAlign.center,),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset('assets/images/LineOne.svg',),
            ],
          ),
          SvgPicture.asset('assets/images/LineOne.svg',),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RegisterScreen();
                  }));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black,
                      )
                  ),
                  child: const Text('Sign up',style: TextStyle(
                      color: Colors.black,
                      fontFamily:'KantumruyPro',
                      fontWeight: FontWeight.w700,
                      fontSize: 32
                  ),textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),


          const Spacer(),
        ],
      ),
    );
  }
}

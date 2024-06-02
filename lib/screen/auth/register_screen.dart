
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/bloc/app_state.dart';
import 'package:hlaw/screen/auth/login_screen.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

   TextEditingController userName =TextEditingController();
   TextEditingController email =TextEditingController();
   TextEditingController password =TextEditingController();

   GlobalKey<FormState> kForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubit,AppState>(
          builder: (context,state){
            var cubit = AppCubit.get(context);
            return SingleChildScrollView(
              padding: EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: kForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SafeArea(child: SizedBox(height: 20,width: double.infinity,)),
                    Image.asset('assets/images/logo2.png'),
                    const SizedBox(height: 20,),
                    const Text('Create Account',style: TextStyle(
                        color:  Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        fontFamily: 'KantumruyPro'
                    ),),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('UserName',style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.start),
                      ],
                    ),

                    TextFormField(
                      controller: userName,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.person,
                          color: Colors.black,),

                        contentPadding: EdgeInsets.all(15),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red
                            )
                        ),
                        focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF822929),
                            )
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Please Enter UserName';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),


                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Email/Number',style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.start),
                      ],
                    ),

                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.email,
                          color: Colors.black,),

                        contentPadding: EdgeInsets.all(15),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red
                            )
                        ),
                        focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF822929),
                            )
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Please Enter Email';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Password',style: TextStyle(
                            color:  Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            fontFamily: 'KantumruyPro'
                        ),textAlign: TextAlign.start),
                      ],
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: cubit.isVLoginPassword,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: ()=>cubit.changeIsVLoginPassword(),
                          child:  Icon(cubit.isVLoginPassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black,),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black
                            )
                        ),
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.red
                            )
                        ),
                        focusedBorder:  const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF822929),
                            )
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Please Enter Password';
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Checkbox(value: cubit.checkBox,
                            onChanged: (val){
                          cubit.changeCheckBox(val!);
                            }),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                                text: 'I read and agree to ',
                                style: const TextStyle(
                                    color:  Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontFamily: 'KantumruyPro'
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Terms & conditions ',
                                    style: const TextStyle(
                                      color:  Color(0XFFAD232B),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      fontFamily: 'KantumruyPro',
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color(0XFFAD232B),
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = (){

                                    },
                                  )
                                ]
                            ),),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15,),

                    (state is LoadingSignUpState)?
                    const Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)) :
                    InkWell(
                      onTap: (){
                        if(kForm.currentState!.validate()){
                          if(cubit.checkBox){
                            cubit.signIn(fullName: userName.text, email: email.text, password: password.text);
                          }else{
                            Fluttertoast.showToast(
                              msg: 'Check Terms & conditions ',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              gravity: ToastGravity.TOP,
                              fontSize: 18,
                              textColor: Colors.white,
                            );
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:  const Color(0XFF822929),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontFamily: 'KantumruyPro'
                            ),textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text('or',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: 'KantumruyPro'
                        ),),

                        SizedBox(width: 20,),
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Image.asset('assets/images/facebook.png'),
                        const SizedBox(width: 20,),
                        Image.asset('assets/images/apple.png'),
                        const SizedBox(width: 20,),
                        Image.asset('assets/images/google.png'),
                        const Spacer(),

                      ],
                    ),
                    const SizedBox(height: 15,),
                    Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(
                                color:  Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                fontFamily: 'KantumruyPro'
                            ),
                            children: [
                              TextSpan(
                                text: ' Login ',
                                style: const TextStyle(
                                  color:  Color(0XFFAD232B),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  fontFamily: 'KantumruyPro',
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0XFFAD232B),
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.pop(context);
                                },
                              )
                            ]
                        ),),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            );
          },
          listener: (context,state){
            if(state is SuccessSignUpState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginScreen();
              }));
            }else if (state is ErrorSignUpState){
              Fluttertoast.showToast(
                msg: 'Please Enter Vaild Data',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                fontSize: 18,
                textColor: Colors.white,
              );
            }

          },
        )
    );
  }
}

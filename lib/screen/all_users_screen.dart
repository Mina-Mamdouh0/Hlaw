
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/bloc/app_state.dart';
import 'package:hlaw/screen/chats/chat_screen.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AppCubit,AppState>(
          builder: (context,state){
            var cubit= AppCubit.get(context);
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
                        child: Text('Users',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 35,
                              fontFamily: 'KantumruyPro'
                          ),),
                      ),

                    ),
                  ),
                  Expanded(child:
                  (state is LoadingGetAllUserState)?
                  const Center(child: CircularProgressIndicator()):
                  ListView.builder(
                      itemCount:cubit.listUsers.length ,
                      itemBuilder: (context,index){
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Image.network(cubit.listUsers[index].image??''),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(cubit.listUsers[index].userName??'',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          fontFamily: 'KantumruyPro'
                                      ),textAlign: TextAlign.center),


                                ],
                              ),
                              const SizedBox(height: 10,),
                              (state is LoadingCreateChatState)?
                              const Center(child: CircularProgressIndicator(),)
                                  :Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: (){
                                        cubit.createChat(uid: cubit.listUsers[index].uId??'',name: cubit.listUsers[index].userName??'');
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color:  const Color(0XFF822929),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text('Chat',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                fontFamily: 'KantumruyPro'
                                            ),textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                 /* const SizedBox(width: 20,),

                                  Expanded(
                                    child: InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          color:  const Color(0XFF822929),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text('Call',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                fontFamily: 'KantumruyPro'
                                            ),textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                            ],
                          ),
                        );
                      }))
                ],
              ),
            );
          },
          listener: (context,state){
            if(state is SuccessCreateChatState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ChatScreen(uid: state.uid??'',name: state.name??'',);
              }));
            }
          },
        )
    );
  }
}

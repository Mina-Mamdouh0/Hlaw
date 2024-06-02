

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_cubit.dart';
import 'package:hlaw/bloc/app_state.dart';
import 'package:hlaw/model/massage_model.dart';
import 'package:hlaw/screen/agora/audioCallScreen.dart';
import 'package:hlaw/screen/agora/videoCallScreen.dart';



class ChatScreen extends StatelessWidget {
  final String uid;
  final String name;
  ChatScreen({Key? key, required this.uid, required this.name}) : super(key: key);

  ScrollController scrollController=ScrollController();
  TextEditingController controller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    var message = FirebaseFirestore.instance.collection('Chats').doc(uid).collection('Massage');
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('created',descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<MessageModel> messageList=[];
            for(int i=0;i<snapshot.data!.docs.length;i++){
              messageList.add(MessageModel.jsonDate(snapshot.data!.docs[i]));
            }
            return Scaffold(
                backgroundColor: const Color(0XFFF0EAEA),
                appBar: AppBar(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  title: Text(name),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VideoCallScreen()));
                      },
                      icon: const Icon(
                        Icons.video_call,
                        size: 30,
                      ),
                      color: Colors.white,
                    ),
                    const SizedBox(width: 15,),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AudioCallScreen()));
                      },
                      icon: const Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          reverse: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: messageList.length,
                          itemBuilder: (context,index){
                            return  messageList[index].id == FirebaseAuth.instance.currentUser?.uid?
                            BubbleChat(message: messageList[index],):
                            BubbleChatFormFriend(message: messageList[index],);
                          }),
                    ),
                    BlocBuilder<AppCubit,AppState>(
                        builder: (context,state){
                          var cubit =AppCubit.get(context);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Expanded(
                                  child: TextField(
                                    controller:controller ,
                                    decoration:  InputDecoration(
                                      hintText: 'message',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder:   OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Color(0XFF822929),
                                              width: 2
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 1
                                          )
                                      ),
                                    ),
                                    onSubmitted: (date){
                                      message.add({
                                        'message': date,
                                        'image':cubit.profileModel?.image??'',
                                        'created':DateTime.now(),
                                        'id':FirebaseAuth.instance.currentUser?.uid,
                                      });
                                      FirebaseFirestore.instance.collection('Chats').doc(uid).update({
                                        'TimeLastMsg':Timestamp.now(),
                                        'LastMsg':controller.text,
                                      });
                                      scrollController.animateTo(
                                        0,
                                        duration:const Duration(milliseconds: 400),
                                        curve: Curves.ease,
                                      );
                                      controller.clear();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                InkWell(
                                  onTap: (){
                                    message.add({
                                      'message': controller.text,
                                      'image':cubit.profileModel?.image??'',
                                      'created':DateTime.now(),
                                      'id':FirebaseAuth.instance.currentUser?.uid,
                                    });

                                    FirebaseFirestore.instance.collection('Chats').doc(uid).update({
                                      'TimeLastMsg':Timestamp.now(),
                                      'LastMsg':controller.text,
                                    });
                                    scrollController.animateTo(
                                      0,
                                      duration:const Duration(milliseconds: 400),
                                      curve: Curves.ease,
                                    );
                                    controller.clear();

                                  },
                                  child: Container(
                                    padding:const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0XFF822929),
                                    ),
                                    child: const Icon(Icons.send,color: Colors.white,size: 30),
                                  ),
                                ),


                              ],
                            ),
                          );
                        })
                  ],
                )
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


}

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    Key? key,required this.message,
  }) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:const EdgeInsets.all(12),
            margin:const EdgeInsets.symmetric(
                vertical: 8,horizontal: 12
            ),
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
            ),
            child: Text(message.message??'',
              style:const TextStyle(
                color: Color(0XFF822929),
                fontSize: 15,
              ),),
          ),
          const SizedBox(width: 2,),
          CircleAvatar(
            backgroundImage: NetworkImage(message?.image??''),
            radius: 20,
          ),
        ],
      ),
    );
  }
}

class BubbleChatFormFriend extends StatelessWidget {
  const BubbleChatFormFriend({
    Key? key,required this.message,
  }) : super(key: key);
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(message?.image??''),
            radius: 20,
          ),
          const SizedBox(width: 2,),
          Container(
            padding:const EdgeInsets.all(12),
            margin:const EdgeInsets.symmetric(
                vertical: 8,horizontal: 12
            ),
            decoration:const BoxDecoration(
                color: Color(0xff822929),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
            ),
            child: Text(message.message??'',
              style:const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),),
          ),

        ],
      ),
    );
  }
}



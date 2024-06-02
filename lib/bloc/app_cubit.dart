
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlaw/bloc/app_state.dart';
import 'package:hlaw/model/chat_model.dart';
import 'package:hlaw/model/massage_model.dart';
import 'package:hlaw/model/profile_model.dart';
import 'package:uuid/uuid.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isVPassword =true;
  void changeIsVPassword(){
    isVPassword = !isVPassword;
    emit(AnyAppState());
  }

  bool isVConfirmPassword =true;
  void changeIsVConfirmPassword(){
    isVConfirmPassword = !isVConfirmPassword;
    emit(AnyAppState());
  }

  bool checkBox =false;
  void changeCheckBox(bool val){
    checkBox = val;
    emit(AnyAppState());
  }

  void signIn({required String fullName,required String email , required String password}){
    emit(LoadingSignUpState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
          ProfileModel profileModel =ProfileModel(
            createdAt: Timestamp.now(),
            email: email,
            image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
            password: password,
            userName: fullName,
            uId: value.user?.uid
          );
          FirebaseFirestore.instance.collection('Users').doc(value.user?.uid)
          .set(profileModel.toMap());
          emit(SuccessSignUpState());
    }).onError((error, stackTrace){
      debugPrint('Error SignUp');
      emit(ErrorSignUpState());
    });
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }

  bool isVLoginPassword =true;
  void changeIsVLoginPassword(){
    isVLoginPassword = !isVLoginPassword;
    emit(AnyAppState());
  }

  void login({required String email , required String password}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password).then((value){
          emit(SuccessLoginState());
          getProfileData();
    }).onError((error, stackTrace){
      emit(ErrorLoginState());
    });
  }

  ProfileModel ? profileModel;
  void getProfileData(){
    emit(LoadingGetDataUserState());
    if(FirebaseAuth.instance.currentUser?.uid != null ){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid)
          .get().then((value){
            profileModel = ProfileModel.jsonDate(value);
            emit(SuccessGetDataUserState());
      }).onError((error, stackTrace){
        emit(ErrorGetDataUserState());
      });
    }
  }

  List<ProfileModel> listUsers=[];
  void getAllUsers(){
    emit(LoadingGetAllUserState());
    listUsers=[];
      FirebaseFirestore.instance.collection('Users').get().
      then((value){
        for (var element in value.docs) {
          ProfileModel p = ProfileModel.jsonDate(element);
          if(FirebaseAuth.instance.currentUser?.uid != p.uId){
            listUsers.add(p);
          }
        }
        emit(SuccessGetAllUserState());
      }).onError((error, stackTrace){
        emit(ErrorGetAllUserState());
      });
  }

  List<ChatModel > l=[];
  void createChat({required String uid ,required String name ,}){
    emit(LoadingCreateChatState());
    l=[];
    try{
      FirebaseFirestore.instance.collection('Chats').get()
          .then((value){
        if(value.docs.isNotEmpty){
          for (var e in value.docs) {
            l.add(ChatModel.jsonData(e));
          }
          if(l.any((element) => ((element.uid==FirebaseAuth.instance.currentUser?.uid) && (element.otherUid == uid))
              ||  ((element.otherUid==FirebaseAuth.instance.currentUser?.uid) && (element.uid == uid))   )){
            String u = l.firstWhere((element) => ((element.uid==FirebaseAuth.instance.currentUser?.uid)&& (element.otherUid == uid)) || ((element.otherUid == FirebaseAuth.instance.currentUser?.uid) && (element.uid == uid))).uidChat??'';
            emit(SuccessCreateChatState(uid: u,name: name));
          }
          else{
            String uuid = const Uuid().v4();
            ChatModel chatModel = ChatModel(
                uidChat: uuid,
                uid: FirebaseAuth.instance.currentUser?.uid,
                timeLastMsg: Timestamp.now(),
                otherUid: uid,
                lastMsg: 'Start Chat',
                name: profileModel?.userName??'',
                otherName: name,
                createdAt: Timestamp.now()
            );
            FirebaseFirestore.instance.collection('Chats').doc(uuid).set(chatModel.toMap()).
            then((value){
              String uuidMassage = const Uuid().v4();
              MessageModel massageModel = MessageModel(
                  message: 'Start Chat',
                  image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                  id: uuidMassage,
                  created: Timestamp.now()
              );
              FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
                  .doc(uuidMassage).set(massageModel.toMap()).then((value){
                emit(SuccessCreateChatState(uid: uuid,name: name));
              }).onError((error, stackTrace){
                emit(ErrorCreateChatState());
              });
            }).onError((error, stackTrace){
              emit(ErrorCreateChatState());
            });
          }
        }else{
          String uuid = const Uuid().v4();
          ChatModel chatModel = ChatModel(
              uidChat: uuid,
              uid: FirebaseAuth.instance.currentUser?.uid,
              timeLastMsg: Timestamp.now(),
              otherUid: uid,
              lastMsg: 'Start Chat',
              name: profileModel?.userName??'',
              otherName: name,
              createdAt: Timestamp.now()
          );
          FirebaseFirestore.instance.collection('Chats').doc(uuid)
              .set(chatModel.toMap()).then((value){
            String uuidMassage = const Uuid().v4();
            MessageModel massageModel = MessageModel(
                message: 'Start Chat',
                image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                id: uuidMassage,
                created: Timestamp.now()
            );
            FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
                .doc(uuidMassage).set(massageModel.toMap()).then((value){
              emit(SuccessCreateChatState(uid: uuid,name: name));
            }).onError((error, stackTrace){
              emit(ErrorCreateChatState());
            });
          }).onError((error, stackTrace){
            emit(ErrorCreateChatState());
          });
        }
      });
    }catch(e){
      String uuid = const Uuid().v4();
      ChatModel chatModel = ChatModel(
          uidChat: uuid,
          uid: FirebaseAuth.instance.currentUser?.uid,
          timeLastMsg: Timestamp.now(),
          otherUid: uid,
          lastMsg: 'Start Chat',
          name: profileModel?.userName??'',
          otherName: name,
          createdAt: Timestamp.now()
      );
      FirebaseFirestore.instance.collection('Chats').doc(uuid)
          .set(chatModel.toMap()).then((value){
        String uuidMassage = const Uuid().v4();
        MessageModel massageModel = MessageModel(
            message: 'Start Chat',
            image: 'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
            id: uuidMassage,
            created: Timestamp.now()
        );
        FirebaseFirestore.instance.collection('Chats').doc(uuid).collection('Massage')
            .doc(uuidMassage).set(massageModel.toMap()).then((value){
          emit(SuccessCreateChatState(uid: uuid,name: name));
        }).onError((error, stackTrace){
          emit(ErrorCreateChatState());
        });
      }).onError((error, stackTrace){
        emit(ErrorCreateChatState());
      });

    }
  }

  List<ChatModel> chatsList=[];
  void getChats(){
    emit(LoadingGetAllChatsState());
    chatsList=[];
    FirebaseFirestore.instance.collection('Chats').get().
    then((value){
      for (var element in value.docs) {
        ChatModel c = ChatModel.jsonData(element);
        if((FirebaseAuth.instance.currentUser?.uid == c.uid) || (FirebaseAuth.instance.currentUser?.uid == c.otherUid)){
          chatsList.add(c);
        }
      }
      emit(SuccessGetAllUserState());
    }).onError((error, stackTrace){
      emit(ErrorGetAllUserState());
    });

  }
}
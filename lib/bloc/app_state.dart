
abstract class AppState{}

class AppInitialState extends AppState{}

class AnyAppState extends AppState{}
class LogoutState extends AppState{}

class LoadingSignUpState extends AppState{}
class SuccessSignUpState extends AppState{}
class ErrorSignUpState extends AppState{}

class LoadingLoginState extends AppState{}
class SuccessLoginState extends AppState{}
class ErrorLoginState extends AppState{}

class LoadingGetDataUserState extends AppState{}
class SuccessGetDataUserState extends AppState{}
class ErrorGetDataUserState extends AppState{}

class LoadingGetAllUserState extends AppState{}
class SuccessGetAllUserState extends AppState{}
class ErrorGetAllUserState extends AppState{}

class LoadingCreateChatState extends AppState{}
class SuccessCreateChatState extends AppState{
  String ? uid;
  String ? name;
  SuccessCreateChatState({this.uid, this.name});
}
class ErrorCreateChatState extends AppState{}

class LoadingGetAllChatsState extends AppState{}
class SuccessGetAllChatsState extends AppState{}
class ErrorGetAllChatsState extends AppState{}

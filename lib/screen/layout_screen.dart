
import 'package:flutter/material.dart';
import 'package:hlaw/screen/all_users_screen.dart';
import 'package:hlaw/screen/chats/all_chats_screen.dart';
import 'package:hlaw/screen/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {


  List<Widget> listScreen=[
    const AllChatsScreen(),
    const AllUsersScreen(),
    const ProfileScreen(),
  ];

  int index= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF0EAEA),
      body: listScreen[index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (val){
         setState(() {
           index=val;
         });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0XFF822929),
        unselectedItemColor: Colors.black,
        items: const [
         /* BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Call'
          ),*/

          BottomNavigationBarItem(
              icon: Icon(Icons.comment_sharp),
              label: 'Chat'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Users'
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),

        ],
      ),
    );
  }
}

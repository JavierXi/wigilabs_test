import 'package:flutter/material.dart';
import 'package:wigilabs/create_user_tab/ui/screens/create_user_screen.dart';
import 'package:wigilabs/users_tab/ui/screens/users.dart';
import 'package:wigilabs/widgets/colors.dart' as color;

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({Key? key}) : super(key: key);

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  final logo = 'assets/logo.png';
  int currentIndex = 0;

  final title = [
    const Text(
      'Usuarios registrados',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
    const Text(
      'Crear usuario',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  ];

  final body = [
    const Users(),
    const CreateUserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                logo,
                width: 40,
              ),
            ),
            const SizedBox(width: 15),
            title[currentIndex],
          ],
        ),
      ),
      body: body[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3BC8FE),
              Color(0xFFDE22F2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.8],
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconSize: 25,
          selectedItemColor: Colors.white,
          selectedFontSize: 10,
          selectedLabelStyle: TextStyle(color: color.AppColor.lightGrayColor),
          unselectedItemColor: color.AppColor.lightGrayColor.withOpacity(0.7),
          unselectedFontSize: 8,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.view_list_outlined),
              activeIcon: Icon(
                Icons.view_list_rounded,
                size: 30,
              ),
              label: 'Usuarios',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person_add_outlined),
              activeIcon: Icon(
                Icons.person_add_rounded,
                size: 30,
              ),
              label: 'Añadir usuario',
            ),
          ],
        ),
      ),
    );
  }
}

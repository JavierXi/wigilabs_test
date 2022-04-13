import 'package:flutter/material.dart';
import 'package:wigilabs/users_tab/models/user_model.dart';
import 'package:wigilabs/users_tab/repository/users_db.dart';
import 'package:wigilabs/widgets/colors.dart' as color;
import 'package:wigilabs/users_tab/repository/users_api.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<List<User>>(
          future: UsersApi.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: color.AppColor.companyFucciaColor,
                    ),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return SizedBox(
                    height: size.height * 0.7,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_rounded,
                          color: color.AppColor.companyFucciaColor,
                          size: 120,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Lo sentimos\nParece que ha ocurrido un error',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  ConnectionState.done;
                  final users = snapshot.data;
                  return snapshot.hasData
                      ? buildItems(users!)
                      : Column(
                          children: [
                            const SizedBox(height: 70),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: color.AppColor.companyFucciaColor,
                                  size: 130,
                                ),
                                Positioned(
                                  top: 29,
                                  left: 29,
                                  child: Icon(
                                    Icons.sentiment_dissatisfied_rounded,
                                    color: color.AppColor.companyFucciaColor,
                                    size: 45,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Aún no hay ningún\nusuario registrado',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 150),
                          ],
                        );
                }
            }
          },
        ),
      ),
    );
  }

  Widget buildItems(List<User> users) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            elevation: 0.5,
            borderOnForeground: false,
            shadowColor: color.AppColor.companyFucciaColor,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
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
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(user.avatar),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              title: Text(
                user.email,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                userDetails(user.id);
              },
            ),
          );
        },
      );

  Future userDetails(int id) async {
    final User? userDBInfo = await UsersDatabase.instance.readUser(id);
    if (userDBInfo != null) {
      print('User info from database');
      userInfoDialog(
        userDBInfo.firstName,
        userDBInfo.lastName,
        userDBInfo.email,
        userDBInfo.avatar,
      );
    } else {
      final userInfo = await UsersApi.getSingleUser(id.toString());
      final saveDB = await UsersDatabase.instance.create(userInfo);
      print('User info = ${userInfo.id}');
      print('User info from internet');
      userInfoDialog(
        userInfo.firstName,
        userInfo.lastName,
        userInfo.email,
        userInfo.avatar,
      );
    }
  }

  Future userInfoDialog(
    String firstName,
    String lastName,
    String email,
    String avatar,
  ) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Detalles del usuario',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 204,
                    width: 204,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
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
                  ),
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(avatar),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                firstName + ' ' + lastName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
}

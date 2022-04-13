import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wigilabs/create_user_tab/repository/create_users_api.dart';
import 'package:wigilabs/create_user_tab/ui/widgets/build_field_widget.dart';
import 'package:wigilabs/create_user_tab/ui/widgets/general_button_widget.dart';
import 'package:wigilabs/widgets/colors.dart' as color;

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Para registrar un nuevo usuario, diligencie el siguiente formulario',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 60),
                BuildFieldWidget(
                  autofocus: true,
                  controller: nameController,
                  capitalization: TextCapitalization.words,
                  prefixIcon: Icons.person_rounded,
                  hintText: 'Nombres',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingresa un nombre válido';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 50),
                BuildFieldWidget(
                  autofocus: false,
                  controller: jobController,
                  capitalization: TextCapitalization.words,
                  prefixIcon: Icons.business_rounded,
                  hintText: 'Trabajo',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingresa un cargo válido';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 70),
                GeneralButtonWidget(
                  label: 'Registrar',
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      createNewUser();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createNewUser() async {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: color.AppColor.companyFucciaColor,
        ),
      ),
    );
    final userInfo = await CreateUsersApi.createUser(
      nameController.text.trim(),
      jobController.text.trim(),
    );
    if (userInfo.statusCode == 201) {
      Map<String, dynamic> userData = json.decode(userInfo.body);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => dialogWidget(
          '¡Felicidades!',
          'El registro se ha completado exitosamente\n\nID: ${userData["id"]}\nNombre: ${nameController.text.trim()}\nRol: ${jobController.text.trim()}\n',
        ),
      );
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => dialogWidget(
          '¡Lo sentimos!',
          'El registro no se pudo completar',
        ),
      );
      return;
    }
  }

  Widget dialogWidget(String title, String content) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.sentiment_very_satisfied,
              size: 30,
              color: color.AppColor.companyBlueColor,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          GeneralButtonWidget(
            label: 'Aceptar',
            onPressed: () {
              nameController.clear();
              jobController.clear();
              Navigator.pop(context);
            },
          ),
        ],
      );
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_xi/ui/views/login/SignUp.dart';
import 'package:proyecto_xi/widgets/Header.dart';
import 'package:proyecto_xi/widgets/Logo.dart';
import 'package:proyecto_xi/widgets/TextFieldCustom.dart';
import '../../../utils/Global.colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = "login_view";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        physics: const BouncingScrollPhysics(),
        children: const [
          Stack(
            children: [
              HeaderLogin(),
              LogoHeader(),
            ],
          ), // Stack
          Title(),
          SizedBox(
            height: 40,
          ), // SizedBox
          EmailAndPassword(),
          ForgotPassword(),
          SizedBox(
            height: 40,
          ), // SizedBox
          ButtonSinIn(),
        ],
      ), // ListView
    ); // Scaffold
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    // todo: implement build

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Text(
            'SIGN IN',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ), // Text
          const Text(
            '/',
            style: TextStyle(fontSize: 25, color: Colors.grey),
          ), // Text
          TextButton(
            onPressed: () {
              Get.to(const SignUp());
            },
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey), // TextStyle
            ), // Text // TextButton
          ),
        ],
      ), // Row
    ); // Padding
  }
}

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFieldCustom(
              type: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              label: 'Email',
              hint: 'Enter email address'), // TextFieldCustom
          const SizedBox(
            height: 40,
          ), // SizedBox
          TextFieldCustom(
              type: TextInputType.visiblePassword,
              icon: Icons.password_outlined,
              label: 'Password',
              hint: 'Enter password',
              pass: true), // TextFieldCustom
        ],
      ), // Column
    ); // Padding
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    // todo: implement build
    return Container(
      padding: const EdgeInsets.only(right: 25, top: 25),
      alignment: Alignment.centerRight,
      child: const Text('Forgot Password'),
    ); // Container
  }
}

class ButtonSinIn extends StatelessWidget {
  const ButtonSinIn({super.key});

  @override
  Widget build(Object context) {
    // todo: implement build
    return Container(
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: GlobalColors.secondaryColorH,
            borderRadius: const BorderRadius.all(Radius.circular(50))), // BoxDecoration
        child: TextButton(
          onPressed: () => {},
          child: const Text(
            'SING IN',
            style: TextStyle(
                height: 3.1,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white), // TextStyle
          ))); // Text // TextButton // Container
  }
}
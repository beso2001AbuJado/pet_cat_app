// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_cats_app/services/auth_service.dart';

import '../shared/dialog_helper.dart';
import '../shared/loading.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 35,
                              fontFamily: "myfont",
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                          height: 21,
                        ),
                        SvgPicture.asset(
                          "assets/icons/signup.svg",
                          height: 200,
                        ),
                        SizedBox(
                          height: 27,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.purple[800],
                                ),
                                hintText: "Username :",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.purple[800],
                                ),
                                hintText: "Email :",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(66),
                          ),
                          width: 266,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: passwordController,
                            obscureText: isObscureText,
                            decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isObscureText = !isObscureText;
                                    });
                                  },
                                  child: Icon(
                                    isObscureText? Icons.visibility: Icons.visibility_off,
                                    color: Colors.purple[900],
                                  ),
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.purple[800],
                                  size: 19,
                                ),
                                hintText: "Password :",
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty ||
                                emailController.text.isEmpty) {
                              DialogHelper.shared.showErrorDialog(
                                  context: context,
                                  subTitle: "All fields are required");
                              return;
                            }
                            if (!validateStructure(passwordController.text)) {
                              DialogHelper.shared.showErrorDialog(
                                  context: context,
                                  title: 'Invalid Password',
                                  subTitle:
                                      "Your password should have Uppercase and lowercase letters, Numerics and Special Characters ( ! @ # \$ & * ~ )");
                              return;
                            }
                            bool isValidCredentials = false;
                            await Loading.wrap(
                              context: context,
                              function: () async {
                                isValidCredentials = await AuthServices.signUp(
                                  username: usernameController.text.trim(),
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              },
                            );
                            if (isValidCredentials) {
                              Navigator.of(context).pushNamed('/login');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    horizontal: 89, vertical: 10)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27))),
                          ),
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an accout? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text(
                                " Log in",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: 299,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.6,
                                color: Colors.purple[900],
                              )),
                              Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.purple[900],
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.6,
                                color: Colors.purple[900],
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.purple, width: 1)),
                                  child: SvgPicture.asset(
                                    "assets/icons/facebook.svg",
                                    color: Colors.purple[400],
                                    height: 27,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.purple, width: 1)),
                                  child: SvgPicture.asset(
                                    "assets/icons/google-plus.svg",
                                    color: Colors.purple[400],
                                    height: 27,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.purple, width: 1)),
                                  child: SvgPicture.asset(
                                    "assets/icons/twitter.svg",
                                    color: Colors.purple[400],
                                    height: 27,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: 111,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: 111,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

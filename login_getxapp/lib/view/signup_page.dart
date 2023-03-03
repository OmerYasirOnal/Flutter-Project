import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_getxapp/view/login_page.dart';

import '../controller/auth_controller.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    List images = ["g.png", "f.png"];

    final controller = Get.put(AuthController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Kayıt Ol',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(30),
              //       boxShadow: [
              //         BoxShadow(
              //             spreadRadius: 5,
              //             blurRadius: 30,
              //             offset: Offset(1, 1),
              //             color: Colors.grey.withOpacity(0.3))
              //       ]),
              //   child: TextField(
              //     controller: userNameController,
              //     decoration: InputDecoration(
              //       hintText: 'Kullanıcı adı',
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: BorderSide(color: Colors.white, width: 1)),
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: BorderSide(color: Colors.white, width: 1)),
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30)),
              //       prefixIcon: Icon(
              //         Icons.person_outline_rounded,
              //         color: Colors.blue,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 30,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.3))
                    ]),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'E-Posta',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 30,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.3))
                    ]),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Şifre',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.password,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  AuthController.intsance.register(emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Kayıt ol',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "Zaten bir hesabım var mı?",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: " Giriş yap",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => LoginPage()),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(
                  text: "Sosyal Medya Hesabınla Oturum Aç",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                )),
              ),
              Wrap(
                children: List<Widget>.generate(
                    2,
                    (index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                "assets/images/" + images[index],
                              ),
                            ),
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

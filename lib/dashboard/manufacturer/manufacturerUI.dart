import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fpidapp/components/round_button.dart';
import 'package:fpidapp/dashboard/manufacturer/manufacturerDashboard.dart';
import 'package:fpidapp/dashboard/manufacturer/newRegister.dart';
import 'package:fpidapp/google_service/googleAuthService.dart';
import 'package:fpidapp/services.dart/forgotPassword.dart';
import 'package:google_fonts/google_fonts.dart';

class manufacturerUI extends StatefulWidget {
  const manufacturerUI({super.key});

  @override
  State<manufacturerUI> createState() => _manufacturerUIState();
}

class _manufacturerUIState extends State<manufacturerUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";

  bool _secureText = true;

  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manufacturer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Glad you back in business !!!",
                  style: TextStyle(
                    fontFamily: GoogleFonts.comfortaa().fontFamily,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Let's get started. Please enter your details",
                  style: TextStyle(
                      fontFamily: GoogleFonts.comfortaa().fontFamily,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: const Icon(CupertinoIcons.mail),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (String value) {
                            email = value;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'Enter your mail' : null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: passwordController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black),
                            prefixIcon: const Icon(CupertinoIcons.padlock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _secureText = !_secureText;
                                });
                              },
                              child: Icon(_secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: _secureText,
                          onChanged: (String value) {
                            password = value;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Enter your password'
                                : null;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                          child: InkWell(
                            child: Container(
                              child: const Text(
                                "Forget Password",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgetPassword()));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: roundButton(
                            title: 'LogIn',
                            onPress: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManufacturerDashboard()));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/googlelogo.png',
                                  height: 50,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            UserCredential? userCredential =
                                await AuthService().signInWithGoogle();
                            if (userCredential != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManufacturerDashboard(),
                                ),
                              );
                            } else {
                              // Handle sign-in failure
                              showToastMessage("Sign-in with Google failed");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Not a member?  ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              child: Text(
                                "Register Now",
                                style: TextStyle(
                                    color: Colors.blue.shade400,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            newManufacturerRegister()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

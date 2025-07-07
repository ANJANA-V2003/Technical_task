import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technical_task/Home_page.dart';

import 'Auth_service.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff14BF9E),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 80,
            child: Container(
              width: 700,
              height: 700,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF39DFBF),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            child: Container(
              width: 610,
              height: 610,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff14BF9E),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            child: Container(
              width: 520,
              height: 520,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF39DFBF),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/Young Man.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 450),
            child: Container(
              height: 460,
              width: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 40),
                    child: Row(
                      children: [
                        Text(
                          "Sign in",
                          style: GoogleFonts.manrope(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Please enter the details below to continue",
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff878787),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Email ID",
                        hintStyle: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          final email = _emailController.text.trim();//trim is used to get the data from the inputtext.
                          final password = _passwordController.text.trim();
                          final authService = AuthService();

                          try {
                            // final userName = await authService.login(
                            //   email,
                            //   password,
                            //  );        method without using models
                            final loginResponse = await authService.login(email, password);

                            final userName = loginResponse.user.userDisplayName; // ✅ correct extraction
                            final emailFromApi = loginResponse.user.email; // here whole data from api is fetched and can be called by using loginresponse.the name
                            final role = loginResponse.user.userType.role;

                            setState(() {
                              _isLoading = false;
                            });

                            _emailController.clear();
                            _passwordController.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  userName: userName, // from API
                                  email: emailFromApi, // from the api
                                  role: role, // from the api
                                ),
                              ),
                            );

                            // showDialog(
                            //   context: context,
                            //   builder:
                            //       (_) => AlertDialog(
                            //         title: Text("Login Successful"),
                            //         content: Text("Welcome $userName"),
                            //         actions: [
                            //           TextButton(
                            //             onPressed: () => Navigator.pop(context),
                            //             child: Text("OK"),
                            //           ),
                            //         ],
                            //       ),
                            // );
                          }
                          catch (e) {
                            setState(() {
                              _isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login failed: $e")),
                            );
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 295,
                          decoration: BoxDecoration(
                            color: Color(0xff14BF9E),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child:
                                _isLoading
                                    ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
                                      "Sign in",
                                      style: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D81E7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

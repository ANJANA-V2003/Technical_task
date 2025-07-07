import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_task/Provider/auth_provider.dart';

class HomePage extends StatelessWidget {
  // final String userName;
  // final String email;
  // final String role;

  const HomePage({
    super.key,
    // required this.userName,
    // required this.email,
    // required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Color(0xff14BF9E),
      ),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<AuthProvider>(
              builder: (context,authProvider, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, ${authProvider.response?.user.fullName??''}!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Email: ${authProvider.response?.user.email??''}',
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Role: ${authProvider.response?.user.userType.role??''}',
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff14BF9E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Logout'),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

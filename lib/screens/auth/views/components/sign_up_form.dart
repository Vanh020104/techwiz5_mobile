import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/screens/auth/views/login_screen.dart';
import 'package:shop/services/register_service.dart';
// import 'package:your_project/services/register_service.dart'; // Ensure this import is correct

class SignUpForm extends StatelessWidget {
   SignUpForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(labelText: 'User Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }   if (value.length < 6) {
                return 'Username must be at least 6 characters long';
              }
               if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                return 'Username can only contain letters and numbers';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              } if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 23),
          ),
          
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }  if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  final response = await RegisterService().register(
                    usernameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                  // Handle successful registration
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Registration successful!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: primaryColor,
                    ),
                  );
                  // Navigator.pushNamed(context, loginScreenRoute);
                  Navigator.pushNamed(context, logInScreenRoute);
                } catch (e) {
                  // Handle registration error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Registration fails!',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(255, 246, 245, 245),
                    ),
                  );
                }
              }
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
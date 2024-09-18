import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/service/login_service.dart';
import '../../../../constants.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginResult = '';

  void _login() async {
  if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Please enter complete information!',
      style: TextStyle(
        color: const Color.fromARGB(255, 255, 85, 73),
        fontSize: 14,
        fontWeight: FontWeight.bold,
        ), // Text color
    ),
    backgroundColor: const Color.fromARGB(255, 246, 245, 245), // Background color
  ),
);
    return;
  }

  final loginService = LoginService();
  final loginModel = LoginModel(
    username: _usernameController.text,
    password: _passwordController.text,
  );

  try {
    final result = await loginService.login(
      loginModel.username,
      loginModel.password,
    );
    setState(() {
      _loginResult = 'Login success!';
      // _loginResult = 'Đăng nhập thành công: ${result.toString()}';
      Navigator.pushNamed(context, homeScreenRoute);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_loginResult,
        style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: primaryColor,
      ),
    );
  } catch (e) {
    setState(() {
      _loginResult = 'Login failed!';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_loginResult,
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'User Name'),
          ),
          Padding(
            padding: EdgeInsets.only(top: defaultPadding),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
           Padding(
            padding: EdgeInsets.only(top: defaultPadding),
          ),
          ElevatedButton(
            onPressed: _login,
            child: Text('Login'),
          ),
          // Padding(padding: EdgeInsets.only(top: 5)),
          
          // Text(_loginResult,
          
          //   style: TextStyle(
          //     color: Colors.red,
          //     fontSize: 14,
              
          //   ),
          // ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, signUpScreenRoute);
                  },
                  child: const Text("Sign up"),
                )
              ],
            ),
          
        ],
        
      ),
    
    );
  }
}
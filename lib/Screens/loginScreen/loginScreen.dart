import 'package:flutter/material.dart';
import '../constraints.dart';
import 'forgetPassword.dart';
import 'loginButton.dart';
import 'orLine.dart';
import 'otherLoginOption.dart';
import 'signupLine.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  bool _showPassword = true;

  _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _endLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  // to clear the resoures
  @override
  void dispose() {
    _email.clear();
    _password.clear();
    _endLoading();
    super.dispose();
  }

  @override
  void initState() {
    _isLoading = false;
    _showPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Email entering filed
    final _emailTextFormField = TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.email_outlined),
        hintText: 'test@test.com',
        labelText: 'Email',
      ),
      controller: _email,
      onChanged: (value) {
        setState(() {});
      },
      keyboardType: TextInputType.emailAddress, // type of keyborad
      textInputAction:
          TextInputAction.next, // Type of action button of keyborad
    );
    final _passwordTextFormField = TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.lock_outline_rounded),
        hintText: 'Enter your Password',
        labelText: 'Password',
      ),
      controller: _password,
      onChanged: (value) {
        setState(() {});
      },
      obscureText: _showPassword,
      keyboardType: TextInputType.visiblePassword, // type of keyborad
      textInputAction:
          TextInputAction.done, // Type of action button of keyborad
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontFamily: regular,
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            // to Dsiplay all the thing in the center horizantly
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(appLogo), // Show the App Logo
              ),
              // From to take care of text input form field
              Form(
                child: Column(
                  children: [
                    _emailTextFormField, // Show Email Entering field
                    const SizedBox(height: 10),
                    _passwordTextFormField, // show password entering field
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: ForgetPasswordLine(), // Show Forget password line
              ),
              _isLoading
                  // if loading don't show login button
                  ? CircularProgressIndicator()
                  // show login button
                  : LoginButton(
                      email: _email.text,
                      password: _password.text,
                      startLoading: _startLoading,
                      endLoading: _endLoading,
                    ),
              const SizedBox(height: 20), // giving space of 20 pixals
              OtherLoginOptions(), // Login with google
              ORLine(), // Show ---- OR ----- line
              SignUpline(), // Show sign up line in the bottom
            ],
          ),
        ),
      ),
    );
  }
}

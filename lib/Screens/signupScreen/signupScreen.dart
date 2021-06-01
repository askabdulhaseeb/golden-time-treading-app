import 'package:flutter/material.dart';
import '../constraints.dart';
import 'loginLine.dart';
import 'otherSignupOption.dart';
import 'signupButton.dart';

class SignUpScreen extends StatefulWidget {
  static final routeName = '/SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // Page Key to menage page

  // Controller to controll user inputs
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _lastNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  // String for all the inputs
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  // clear all the Data
  clearAll() {
    setState(() {
      _firstName = '';
      _lastName = '';
      _email = '';
      _password = '';

      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Design First Name Input Field
    final _firstNameTextFormField = TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter your First Name',
        labelText: 'First Name',
      ),
      controller: _firstNameController,
      onChanged: (value) {
        setState(() {
          _firstName = value;
        });
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
    // Design Last Name Input Field
    final _lastNameTextFormField = TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter your Last Name',
        labelText: 'Last Name',
      ),
      controller: _lastNameController,
      onChanged: (value) {
        setState(() {
          _lastName = value;
        });
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
    // Design Email Input Field
    final _emailTextFormField = TextFormField(
      decoration: const InputDecoration(
        hintText: 'test@test.com',
        labelText: 'Email',
      ),
      controller: _emailController,
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
    // Design Password Input Text Field
    final _passwordTextFormField = TextFormField(
      decoration: const InputDecoration(
        hintText: 'Enter your Password',
        labelText: 'Password',
      ),
      controller: _passwordController,
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false, // Show Keyborad
      // App Bar
      appBar: AppBar(
        title: Text(
          'Registration',
          style: TextStyle(
            fontSize: 28,
            fontFamily: regular,
          ),
        ),
      ),
      // space form all sides of page
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // align all widgets vertically
        child: Column(
          children: [
            // save the state of all input form
            Form(
              key: _formKey,
              // show all the Input Text Form Field vertically
              child: Column(
                children: [
                  _firstNameTextFormField,
                  _lastNameTextFormField,
                  _emailTextFormField,
                  _passwordTextFormField,
                ],
              ),
            ),
            // Align Widgets horizantly
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                Text('I agree all the tearms and conditions'),
              ],
            ),
            // Signup Button
            SignupButton(
              name: "$_firstName $_lastName",
              email: _email,
              password: _password,
              clearAll: clearAll,
            ),
            const SizedBox(height: 20),
            // Sign up with Google
            OtherSignupOption(),
            const SizedBox(height: 20),
            // back to login screen line
            LoginLine(),
          ],
        ),
      ),
    );
  }
}

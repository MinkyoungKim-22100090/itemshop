// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            OverflowBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                TextButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),);
                  },
                ),
                ElevatedButton(
                  child: const Text('NEXT'),
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                const SizedBox(height: 120.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is invalid';
                    }
                    else if (value.length < 6){
                      return 'Username is invalid';
                    }
                    else{
                      RegExp alphabet = RegExp(r'[a-zA-Z]');
                      RegExp number = RegExp(r'\d');
                      int alphabetCount = alphabet.allMatches(value).length;
                      int numberCount = number.allMatches(value).length;
                      if (alphabetCount < 3 || numberCount < 3) {
                        return 'Username is invalid';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is invalid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Confirm Password doesnʼt match Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

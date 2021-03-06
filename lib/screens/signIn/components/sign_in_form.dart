import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/bottom_nav_bar.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/size_config.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "로그인",
            textScaleFactor: 1,
            style: TextStyle(
                color: kActiveColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          VerticalSpacing(
            of: 30,
          ),
          Text(
            " 이메일",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            controller: _emailController,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return '이메일을 입력해주세요.';
              }
              return null;
            },
          ),
          VerticalSpacing(of: 20),
          Text(
            " 비밀번호",
            textScaleFactor: 1,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: kBodyTextColor),
          ),
          VerticalSpacing(),
          TextFormField(
            controller: _passwordController,
            style: TextStyle(fontSize: 15),
            decoration: InputDecoration(
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            validator: (String value) {
              if (value.isEmpty) return '비밀번호를 입력해주세요.';
              if (value.length < 6) return '6자리 이상 입력해주세요';

              return null;
            },
            obscureText: true,
          ),
          VerticalSpacing(
            of: 30,
          ),
          PrimaryButton(
            text: "로그인",
            press: () async {
              if (_formKey.currentState.validate()) {
                _signInWithEmailAndPassword().then((user) {
                  if (user != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar(user)));
                  } else {}
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  showErrDialog(BuildContext context, String err) {
    return Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        err,
        textAlign: TextAlign.center,
        textScaleFactor: 1,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      backgroundColor: kActiveColor,
    ));
  }

  // Example code of how to sign in with email and password.
  Future<User> _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          showErrDialog(context, '이메일 형식이 맞지 않습니다.');
          break;
        case 'wrong-password':
          showErrDialog(context, '비밀번호가 올바르지 않습니다.');
          break;
        case 'user-not-found':
          showErrDialog(context, '가입된 이메일이 아닙니다.');
          break;
        case 'user-disabled':
          showErrDialog(context, e.code);
          break;
        case 'too-many-requests':
          showErrDialog(context, e.code);
          break;
        case 'operation-not-allowed':
          showErrDialog(context, e.code);
          break;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }
}

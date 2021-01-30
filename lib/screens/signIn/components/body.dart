import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/widgets/bottom_nav_bar.dart';
import 'package:hellocock/widgets/buttons/social_button.dart';
import '../../../size_config.dart';
import '../../../screens/signUp/sign_up_screen.dart';
import 'sign_in_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<User> _googlelogin() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    User user = (await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken)))
        .user;
    // 로그인 정보를 출력하는 로그
    print("signed in " + user.displayName);
    return user;
  }

  Future<User> _facebooklogin() async {
    FacebookLoginResult result =
        await _facebookLogin.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken.token);
        User user = (await _firebaseAuth.signInWithCredential(credential)).user;

        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        return user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        return null;
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        return null;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(of: 100),
            SignInForm(),
            VerticalSpacing(
              of: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    child: Text(
                  "이메일 찾기",
                  style: TextStyle(fontSize: 12),
                )),
                SizedBox(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 1,
                    color: kBodyTextColor,
                  ),
                ),
                InkWell(
                    child: Text(
                  "비밀번호 찾기",
                  style: TextStyle(fontSize: 12),
                )),
                SizedBox(
                  height: 10,
                  child: VerticalDivider(
                    thickness: 1,
                    color: kBodyTextColor,
                  ),
                ),
                InkWell(
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        ),
                    child: Text(
                      "회원가입",
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            ),
            VerticalSpacing(
              of: 50,
            ),
            SizedBox(
              height: 40,
              child: SocialButton(
                  text: "페이스북 이메일로 로그인",
                  image: "assets/icons/facebook.svg",
                  press: () {
                    _facebooklogin().then((user) {
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(user.email)
                          .set({
                        'name': user.displayName,
                        'email': user.email,
                        'address1': "",
                        'address2': "",
                        'phone': "",
                        'like': null,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(user)));
                    });
                  },
                  color: Color(0xFF1877F2),
                  textcolor: Colors.white),
            ),
            VerticalSpacing(
              of: 20,
            ),
            SizedBox(
              height: 40,
              child: SocialButton(
                  text: "구글 이메일로 로그인",
                  image: "assets/icons/google.svg",
                  press: () {
                    _googlelogin().then((user) {
                      FirebaseFirestore.instance
                          .collection("user")
                          .doc(user.email)
                          .set({
                        'name': user.displayName,
                        'email': user.email,
                        'address1': "",
                        'address2': "",
                        'phone': "",
                        'like': null,
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(user)));
                    });
                  },
                  color: Colors.white,
                  textcolor: Colors.grey),
            ),
            VerticalSpacing(
              of: 20,
            ),
          ],
        ),
      ),
    );
  }
}

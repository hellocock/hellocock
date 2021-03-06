import 'package:flutter/material.dart';
import 'package:hellocock/size_config.dart';
import '../../../constants.dart';
import 'sign_up_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalSpacing(
                of: 10,
              ),
              Text(
                "회원가입",
                textScaleFactor: 1,
                style: TextStyle(
                    color: kActiveColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(
                of: 35,
              ),
              SignUpForm(),
              VerticalSpacing(
                of: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

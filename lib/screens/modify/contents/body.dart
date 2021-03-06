import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/screens/modify/contents/modify_form.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final User user;
  Body(this.user);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(widget.user.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(kActiveColor),
            );
          return ModifyForm(widget.user, snapshot.data);
        });
  }
}

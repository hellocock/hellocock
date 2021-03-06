import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../size_config.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final GestureTapCallback press;
  final Color color;
  final Color textcolor;
  final String image;
  const SocialButton(
      {Key key,
      @required this.text,
      @required this.press,
      @required this.color,
      @required this.textcolor,
      @required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    EdgeInsets verticalPadding =
        EdgeInsets.symmetric(vertical: getProportionateScreenWidth(13));
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: RaisedButton(
          padding: verticalPadding,
          elevation: 3,
          color: color,
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              Text(
                text,
                textScaleFactor: 1,
                style: TextStyle(
                    fontSize: 13,
                    color: textcolor,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}

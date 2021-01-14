import 'package:flutter/material.dart';
import 'package:hellocock/widgets/bottom_nav_bar.dart';
import 'package:hellocock/widgets/buttons/primary_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                " 주문 완료",
                style: TextStyle(
                    color: kActiveColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              VerticalSpacing(
                of: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "블루 하와이 칵테일 키트",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kBodyTextColor,
                    fontSize: 15,
                  ),
                ),
              ),
              VerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "주문일시",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text("2020/12/05 pm19:45")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "주문번호",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text("B0D051135")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "픽업장소",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text("궤도에 오르다")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "픽업시간",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kBodyTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text("pm20:30")
                ],
              ),
              VerticalSpacing(
                of: 30,
              ),
              Center(
                child: Container(
                  width: 275,
                  height: 189,
                  child: Image.asset("assets/images/identification.png"),
                ),
              ),
              VerticalSpacing(of: 20),
              Center(
                child: Text(
                  "가게가 혼잡할 수 있으니 신분증을 미리 준비해주세요!",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              VerticalSpacing(
                of: 170,
              ),
              PrimaryButton(
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavBar(),
                  ),
                ),
                text: "홈으로 돌아가기",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
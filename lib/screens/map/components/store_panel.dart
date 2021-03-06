import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellocock/constants.dart';
import 'package:hellocock/screens/menu/menu_screen.dart';
import 'package:hellocock/screens/order/order_screen.dart';
import 'package:hellocock/size_config.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StorePanel extends StatefulWidget {
  final User user;
  final DocumentSnapshot cocktaildocument;
  StorePanel(this.user, this.cocktaildocument);
  @override
  _StorePanelState createState() => _StorePanelState();
}

class _StorePanelState extends State<StorePanel> {
  PanelController _pc1 = new PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
        controller: _pc1,
        minHeight: 300,
        maxHeight: 600,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0), topRight: Radius.circular(35)),
        panelBuilder: (ScrollController sc) => _buildpanel1(sc));
  }

  Widget _buildpanel1(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            VerticalSpacing(
              of: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 45,
                  height: 3.5,
                  decoration: BoxDecoration(
                      color: Color(0xFF6F6F6F),
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30.0, bottom: 20),
              child: Text(
                "픽업 장소 및 시간",
                textScaleFactor: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: kActiveColor),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('store')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(kActiveColor),
                      ),
                    );
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListStore(snapshot.data.docs[index]);
                    },
                  );
                }),
          ],
        ));
  }

  Widget _buildListStore(DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: document['image'],
                height: 145,
                width: 145,
                fit: BoxFit.cover,
              )),
          HorizontalSpacing(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                document['name'],
                textScaleFactor: 1,
                style: TextStyle(
                    color: kBodyTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    height: 1.5),
              ),
              VerticalSpacing(of: 5),
              Text(
                document['explain'].replaceAll("\\n", "\n"),
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 12,
                  color: kBodyTextColor,
                ),
              ),
              VerticalSpacing(of: 5),
              Text(
                document['opening_hours'],
                textScaleFactor: 1,
                style: TextStyle(
                  fontSize: 12,
                  color: kBodyTextColor,
                ),
              ),
              VerticalSpacing(
                of: 5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: RaisedButton(
                      child: Text(
                        "안주보기",
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor,
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuScreen(
                              widget.user, widget.cocktaildocument, document),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  HorizontalSpacing(
                    of: 10,
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: RaisedButton(
                      child: Text(
                        "수령하기",
                        textScaleFactor: 1,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kBodyTextColor,
                        ),
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("cart")
                            .doc(widget.user.email)
                            .update(
                          {
                            'store': document['name'],
                            'pickup_time': DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                18,
                                00),
                          },
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderScreen(widget.user, document),
                            ));
                      },
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              VerticalSpacing(of: 5),
            ],
          ),
        ],
      ),
    );
  }
}

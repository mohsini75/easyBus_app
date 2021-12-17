import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/users/student/detail_view.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class ViewUserCard extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  ViewUserCard(@required this.snapshot);

  @override
  _ViewUserCardState createState() => _ViewUserCardState();
}

class _ViewUserCardState extends State<ViewUserCard> {
  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
      return //new Text(document['name']);
          InkWell(
        child: new Card(
          elevation: 2,
          child: true //document['role'] == widget.role
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20, // light // italic
                            ),
                          ),
                          Text(
                            document['regNo'],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20, // light// italic
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Route",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16, // light
                                color: Colors.black // italic
                                ),
                          ),
                          Text(
                            document['routeNo'],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24, // light
                                color: Colors.green // italic
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DetailViewCard(document);
          }));
          //DetailViewCard(document.id);
        },
      );
    }).toList());
  }
}

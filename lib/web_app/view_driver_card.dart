import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class ViewDriverCard extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  ViewDriverCard(@required this.snapshot);

  @override
  _ViewDriverCardState createState() => _ViewDriverCardState();
}

class _ViewDriverCardState extends State<ViewDriverCard> {
  var _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: widget.snapshot.data!.docs.map((DocumentSnapshot document) {
        return //new Text(document['name']);
            InkWell(
          child: new Card(
            elevation: 2,
            child: true //document['role'] == "driver"
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
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
                              document['cnic'],
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
                              document['route'],
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
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return DetailViewCard(document);
            // }));
            //DetailViewCard(document.id);
          },
        );
      }).toList()),
    );
  }
}

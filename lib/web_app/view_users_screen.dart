import 'package:cloud_firestore/cloud_firestore.dart';

import 'view_driver_card.dart';
import 'package:flutter/material.dart';

class ViewDriverScreen extends StatefulWidget {
  static final routeName = "/view_students";

  final String role;

  ViewDriverScreen(this.role);

  @override
  State<ViewDriverScreen> createState() => _ViewDriverScreenState();
}

class _ViewDriverScreenState extends State<ViewDriverScreen> {
  //var _listItems = <Widget>[];
  // final GlobalKey<AnimatedListState> searchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String searchKey = "";
    Stream streamQuery =
        FirebaseFirestore.instance.collection("users").snapshots();

    TextEditingController textController = new TextEditingController();
    // void _updateSearchKey() {
    //   searchKey = textController.text;
    // }

    @override
    void initState() {
      super.initState();

      // Start listening to changes.
      //textController.addListener(_updateSearchKey);
    }

    // @override
    // void dispose() {
    //   // Clean up the controller when the widget is removed from the widget tree.
    //   // This also removes the _printLatestValue listener.
    //   //textController.removeListener(_updateSearchKey);
    //   textController.dispose();
    //   super.dispose();
    // }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            title: Text(
              'Registered ${widget.role}s ',
              style: TextStyle(color: Colors.blue.shade300, letterSpacing: 2),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.blue.shade300,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
            /*
            bottom: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Container(
                width: double.infinity,
                height: 50,
                //color: Colors.purple.shade100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                //color: Colors.purple.shade100),
                child: true
                    ? Container()
                    : Center(
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: "Search a ${widget.role}",
                              hintStyle: TextStyle(color: Colors.blue),
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: new IconButton(
                                icon: new Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    textController.clear();
                                  });
                                },
                              )),
                          //controller: textController,
                          // onChanged: (value) {
                          //   setState(() {
                          //     searchKey = value.toLowerCase();
                          //     //textController.text = value;
                          //   });
                          // print(searchKey);
                          onSubmitted: (value) {
                            setState(() {
                              searchKey = value;
                            });
                          },
                        ),
                      ),
              ),
            ),
            */
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Card(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where('role', isEqualTo: "driver")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError)
                          return new Text('${snapshot.error}');
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (snapshot.hasError)
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            if (!snapshot.hasData)
                              return Text('No data finded!');
                            return Card(
                              child: SingleChildScrollView(
                                  child: ViewDriverCard(snapshot)),
                            );
                        }
                      },
                    ),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

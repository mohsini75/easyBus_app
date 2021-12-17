import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class transactionDatabase {
  // databse se get kary ga data
  Widget StreamCommon(
    Stream<QuerySnapshot> selected,
    String title,
  ) {
    return StreamBuilder<QuerySnapshot>(
        stream: selected,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text("Something went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          final data = snapshot.requireData;
          print("data require ho gaya ha ");
          return Container(
            height: MediaQuery.of(context).size.height * 1,
            child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.price_change),
                        ),
                        subtitle: Text(DateFormat.yMMMEd()
                            .format(DateTime.now())
                            .toString()),
                        title: Text("${data.docs[index][title]}"),
                        //trailing: Text("${data.docs[index][trailing]}"),
                      ),
                    ),
                  ],
                );
                // ma ye kaaha raha ho driver ka na show ho par jab add karo tu error na dee bas DB me save ho jai
              },
            ),
          );
        });
  }

  // Widget StreamStudentComplain(Stream<QuerySnapshot> selected, String domain1,
  //     String domain2, String domain3) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: selected,
  //       builder: (
  //         BuildContext context,
  //         AsyncSnapshot<QuerySnapshot> snapshot,
  //       ) {
  //         if (snapshot.hasError) {
  //           return Text("Something went Wrong");
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Text("Loading...");
  //         }
  //         final data = snapshot.requireData;
  //         print("data require ho gaya ha ");
  //         return Container(
  //           height: MediaQuery.of(context).size.height * 1,
  //           child: ListView.builder(
  //             itemCount: data.size,
  //             itemBuilder: (context, index) {
  //               return Column(
  //                 children: [
  //                   Card(
  //                     shape: BeveledRectangleBorder(
  //                       borderRadius: BorderRadius.circular(20.0),
  //                     ),
  //                     child: ListTile(
  //                       leading: Text("Route: ${data.docs[index][domain1]}"),
  //                       subtitle: Text("${data.docs[index][domain2]}"),
  //                       title: Text("${data.docs[index][domain3]}"),
  //                       trailing: IconButton(
  //                         icon: Icon(Icons.arrow_drop_down),
  //                         onPressed: () {},
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //               // ma ye kaaha raha ho driver ka na show ho par jab add karo tu error na dee bas DB me save ho jai
  //             },
  //           ),
  //         );
  //       });
  // }

  // Widget StreamDriverComplain(
  //     Stream<QuerySnapshot> selected, String domain1, String domain2) {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: selected,
  //       builder: (
  //         BuildContext context,
  //         AsyncSnapshot<QuerySnapshot> snapshot,
  //       ) {
  //         if (snapshot.hasError) {
  //           return Text("Something went Wrong");
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Text("Loading...");
  //         }
  //         final data = snapshot.requireData;
  //         print("data require ho gaya ha ");
  //         return Container(
  //           height: MediaQuery.of(context).size.height * 1,
  //           child: ListView.builder(
  //             itemCount: data.size,
  //             itemBuilder: (context, index) {
  //               return Column(
  //                 children: [
  //                   Card(
  //                     shape: BeveledRectangleBorder(
  //                       borderRadius: BorderRadius.circular(20.0),
  //                     ),
  //                     child: ListTile(
  //                       subtitle: Text("${data.docs[index][domain1]}"),
  //                       title: Text("${data.docs[index][domain2]}"),
  //                       trailing: IconButton(
  //                         icon: Icon(Icons.arrow_drop_down),
  //                         onPressed: () {},
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //               // ma ye kaaha raha ho driver ka na show ho par jab add karo tu error na dee bas DB me save ho jai
  //             },
  //           ),
  //         );
  //       });
  // }
}

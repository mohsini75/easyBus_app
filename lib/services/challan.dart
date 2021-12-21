import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/student.dart';
import 'package:demo/providers/mobile.dart' if (dart.library.html) 'web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Challan extends StatefulWidget {
  Challan();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ChallanState createState() => _ChallanState();
}

class _ChallanState extends State<Challan> {
  late Map<String, dynamic> mapData;
  late double totalFee;
  initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .first
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      mapData = querySnapshot.docs.first.data();
    });
  }

  Future<int> getTransCount() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .length;
  }

  // Student s = Student(
  //     name: "Mohsin",
  //     regNo: "SP18-BSE-117",
  //     email: "email",
  //     contact: "",
  //     routeNo: 12,
  //     price: 250,
  //     date: DateTime.now(),
  //     address: "address",
  //     feeClearance: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Open Challan'),
          onPressed: _createPDF,
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    final PdfPageTemplateElement headerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the header.
    headerTemplate.graphics.drawString('Easy Bus Portal Fee Challan',
        PdfStandardFont(PdfFontFamily.helvetica, 26),
        bounds: const Rect.fromLTWH(0, 15, 600, 60));
//Add the header element to the document.
    document.template.top = headerTemplate;

    // page.graphics.drawString('',
    //     PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(PdfBitmap(await _readImageData('splash_image.PNG')),
        Rect.fromLTWH(200, 100, 200, 150));

    final PdfOrderedList orderedList = PdfOrderedList(
        items: PdfListItemCollection(<String>[
          'Name:\t${mapData['name']}',
          'Reg No.\t${mapData['regNo']}',
          'ID:\t${mapData['id']}',
          'Date:\t${DateTime.now().toString()}',
          'Price:\t${await getTransCount() * 150}',
          "Due Date:\t${DateTime.now().toString()}"
        ]),
        marker: PdfOrderedMarker(
            style: PdfNumberStyle.none,
            font: PdfStandardFont(PdfFontFamily.helvetica, 20)),
        markerHierarchy: true,
        format: PdfStringFormat(lineSpacing: 40),
        textIndent: 40);
// Create a un ordered list and add it as a sublist.

// Draw the list to the PDF page.
    orderedList.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 20, page.getClientSize().width, page.getClientSize().height));

    // PdfGrid grid = PdfGrid();
    // grid.style = PdfGridStyle(
    //     font: PdfStandardFont(PdfFontFamily.helvetica, 30),
    //     cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    // grid.columns.add(count: 3);
    // grid.headers.add(1);

    // PdfGridRow header = grid.headers[0];
    // header.cells[0].value = 'Roll No';
    // header.cells[1].value = 'Name';
    // header.cells[2].value = 'Class';

    // PdfGridRow row = grid.rows.add();
    // row.cells[0].value = '1';
    // row.cells[1].value = 'Arya';
    // row.cells[2].value = '6';

    // row = grid.rows.add();
    // row.cells[0].value = '2';
    // row.cells[1].value = 'John';
    // row.cells[2].value = '9';

    // row = grid.rows.add();
    // row.cells[0].value = '3';
    // row.cells[1].value = 'Tony';
    // row.cells[2].value = '8';

    final PdfPageTemplateElement footerTemplate =
        PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the footer.
    footerTemplate.graphics.drawString(
        '***Please issue the challan, paid challan is mandatory for the rides***',
        PdfStandardFont(PdfFontFamily.helvetica, 16),
        bounds: const Rect.fromLTWH(0, 15, 800, 30));
//Set footer in the document.
    document.template.bottom = footerTemplate;

    //document.pages.add();

// PdfSignatureField signatureField = PdfSignatureField(page, 'Signature',
//     bounds: Rect.fromLTWH(0, 0, 200, 50),
//     signature: PdfSignature(
//        certificate:
//           PdfCertificate(File('certificate.pfx').readAsBytesSync(), 'password@123')
//     ));

// //Add the signature field to the document.
// document.form.fields.add(signatureField);

    // grid.draw(
    //     page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'fee challan.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}

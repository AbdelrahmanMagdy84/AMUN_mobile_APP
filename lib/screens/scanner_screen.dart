import 'package:amun/drawer/doctors_connections_screen.dart';
import 'package:amun/models/Doctor.dart';
import 'package:amun/models/Responses/DoctorsResponse.dart';
import 'package:amun/services/APIClient.dart';
import 'package:amun/utils/TokenStorage.dart';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  static final String routeName = "Scanner screen";
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;
  String qr;
   @override
  didChangeDependencies() {
    getUserToken();
    super.didChangeDependencies();
  }

  List<Doctor> doctorList = List();
  Future userFuture;

  String _patientToken;
  void getUserToken() {
    TokenStorage().getUserToken().then((value) async {
      setState(() {
        _patientToken = value;
      });

       APIClient()
          .getFacilityPatientService()
          .getDoctors(_patientToken)
          .then((DoctorsResponse responseList) {
        if (responseList.success) {
          doctorList = responseList.doctors;
          doctorList = doctorList.reversed.toList();
        }
      });
    });
  }


  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool scanned = false;
    controller.scannedDataStream.listen((scanData) {
      if (!scanned) {
        scanned = true;
        qrText = scanData;
        Navigator.of(context).pushReplacementNamed(DoctorConnectionScreen.routeName,
            arguments: {"id": qrText,'myDoctors':doctorList});
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Decoration decoration;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("AMUN MR"),
      ),
      //drawer: MainDrawer(),
      drawerScrimColor: Theme.of(context).accentColor,
      body: Container(
        padding:
            EdgeInsets.only(top: mediaQuery.height * 0.1, right: 10, left: 10),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 4, color: Theme.of(context).primaryColor),
              ),
              //color: Colors.amberAccent,
              height: mediaQuery.height * 0.5,
              // width: mediaQuery.width*0.5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: mediaQuery.height * 0.05),
              child: Center(
                child: Text(
                  'Scan result: $qrText',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

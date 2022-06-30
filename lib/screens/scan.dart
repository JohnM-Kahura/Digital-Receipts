// import 'dart:html';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scan extends StatefulWidget {
  const Scan({Key? key}) : super(key: key);

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  final qr_key = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  Future saveQrData(String? data) async {
    Map<String, dynamic> qr_data = jsonDecode(data!);
    qr_data['date'] = DateTime.now();
    print(qr_data);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection('receipts').add(qr_data);
   
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Scan QR')),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qr_key,
            onQRViewCreated: onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderWidth: 10,
              borderLength: 20,
              borderRadius: 10,
              borderColor: Colors.green,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                barcode != null ? 'Succefully Scanned!!!' : 'Scan a code!',
                maxLines: 4,
                style:TextStyle(color: Colors.green)
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () {
                saveQrData(barcode!.code);
                Navigator.of(context).pop();
                
              },
              child: const Text(
                'Save ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((barcode) => setState(() {
          this.barcode = barcode;
        }));
  }
}

import 'package:flutter/material.dart';
//import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBarPage extends StatefulWidget {
  const ScannerBarPage({super.key});

  @override
  State<ScannerBarPage> createState() => _ScannerBarPageState();
}

class _ScannerBarPageState extends State<ScannerBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: const SizedBox(
        height: 400,
        child: /*MobileScanner(onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            print(barcode.rawValue ?? "No Data found in QR");
          }
        }),*/
            Text('Scanner'),
      ),
    );
  }
}

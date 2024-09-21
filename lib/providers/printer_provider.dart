// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
// import 'package:flutter_thermal_printer/utils/printer.dart';

// class PrinterProvider extends ChangeNotifier {
//   final FlutterThermalPrinter _flutterThermalPrinterPlugin =
//       FlutterThermalPrinter.instance;
//   List<Printer> printers = [];
//   StreamSubscription<List<Printer>>? _devicesStreamSubscription;

//   void startScan() async {
//     _devicesStreamSubscription?.cancel();
//     await _flutterThermalPrinterPlugin
//         .getPrinters(connectionTypes: [ConnectionType.USB]);
//     _devicesStreamSubscription = _flutterThermalPrinterPlugin.devicesStream
//         .listen((List<Printer> event) {
//       log(event.map((e) => e.name).toList().toString());
//       printers = event
//           .where((element) => element.name != null && element.name != '')
//           .toList();
//       notifyListeners();
//     });
//   }

//   void stopScan() {
//     _devicesStreamSubscription?.cancel();
//     _flutterThermalPrinterPlugin.stopScan();
//   }

//   Future<void> toggleConnection(Printer printer) async {
//     if (printer.isConnected ?? false) {
//       await _flutterThermalPrinterPlugin.disconnect(printer);
//     } else {
//       final isConnected = await _flutterThermalPrinterPlugin.connect(printer);
//       log("Device connected: $isConnected");
//     }
//     notifyListeners();
//   }

//   Future<void> printReceipt(Printer printer) async {
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//     List<int> bytes = [];
//     bytes += generator.qrcode('a');
//     // bytes += generator.text('Foodchow Demo',
//     styles:
//     const PosStyles(
//         align: PosAlign.center,
//         height: PosTextSize.size2,
//         width: PosTextSize.size2);
//     bytes +=
//         generator.text('#AU-2', styles: const PosStyles(align: PosAlign.right));
//     bytes += generator.text('13 Sep 2024 03:30 PM',
//         styles: const PosStyles(align: PosAlign.center));
//     bytes += generator.feed(1);
//     bytes += generator.cut();
//     // print(bytes);

//     await _flutterThermalPrinterPlugin.printData(printer, bytes,
//         longData: true);
//   }
// }

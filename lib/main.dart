import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';
// import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Label Printer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Custom Label Printer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File file = File('assets/fonts/NotoSans-Regular.ttf');
  late Uint8List bytes = file.readAsBytesSync();

  final fallbackFontList = [
    pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSerifHK[wght].ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSerifJP[wght].ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSerifKR[wght].ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSerifSC[wght].ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSerifTC[wght].ttf')
        .readAsBytesSync()
        .buffer)),
    // pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSansCJKhk-VF.ttf')
    //     .readAsBytesSync()
    //     .buffer)),
    // pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSansCJKjp-VF.ttf')
    //     .readAsBytesSync()
    //     .buffer)),
    // pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSansCJKkr-VF.ttf')
    //     .readAsBytesSync()
    //     .buffer)),
    // pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSansCJKsc-VF.ttf')
    //     .readAsBytesSync()
    //     .buffer)),
    // pw.Font.ttf(ByteData.view(File('assets/cjk_fonts/NotoSansCJKtc-VF.ttf')
    //     .readAsBytesSync()
    //     .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoFangsongKSSRotated-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoFangsongKSSVertical-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoKufiArabic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoMusic-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoNaskhArabic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoNaskhArabicUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoNastaliqUrdu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoRashiHebrew-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSans-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansAdlam-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansAdlamUnjoined-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansAnatolianHieroglyphs-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansArabic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansArabicUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansArmenian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansAvestan-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBalinese-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBamum-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBassaVah-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBatak-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBengali-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBengaliUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBhaiksuki-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBrahmi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBuginese-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansBuhid-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansCanadianAboriginal-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCarian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansCaucasianAlbanian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansChakma-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCham-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCherokee-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansChorasmian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCoptic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCuneiform-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansCypriot-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansCyproMinoan-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansDeseret-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    // pw.Font.ttf(ByteData.view(
    //     File('assets/fonts/NotoSansDevanagari-Regular.otf')
    //         .readAsBytesSync()
    //         .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansDevanagariUI-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansEgyptianHieroglyphs-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansElbasan-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansElymaic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansEthiopic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansGeorgian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansGlagolitic-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansGothic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansGrantha-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansGujarati-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansGujaratiUI-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansGunjalaGondi-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansGurmukhi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansGurmukhiUI-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansHanifiRohingya-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansHanunoo-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansHatran-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansHebrew-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansImperialAramaic-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansIndicSiyaqNumbers-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansInscriptionalPahlavi-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansInscriptionalParthian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansJavanese-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKaithi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKannada-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKannadaUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKawi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKayahLi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansKharoshthi-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKhmer-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKhojki-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansKhudawadi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansLao-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLaoLooped-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLepcha-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLimbu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLinearA-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLinearB-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLisu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLycian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansLydian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMahajani-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMalayalam-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMalayalamUI-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMandaic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansManichaean-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMarchen-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMasaramGondi-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMath-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMayanNumerals-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMedefaidrin-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMeeteiMayek-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMendeKikakui-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMeroitic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMiao-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansModi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMongolian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansMro-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMultani-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansMyanmar-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansNabataean-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansNagMundari-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansNandinagari-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansNewa-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansNewTaiLue-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansNKo-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansNKoUnjoined-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansNushu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOgham-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOlChiki-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansOldHungarian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOldItalic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansOldNorthArabian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOldPermic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansOldPersian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansOldSogdian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansOldSouthArabian-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOldTurkic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOriya-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOsage-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansOsmanya-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansPahawhHmong-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansPalmyrene-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansPauCinHau-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansPhagsPa-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansPhoenician-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansPsalterPahlavi-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansRejang-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansRunic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSamaritan-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSaurashtra-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSharada-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansShavian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSiddham-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSignWriting-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSinhala-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSinhalaUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSogdian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSoraSompeng-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSoyombo-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSundanese-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSylotiNagri-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSymbols-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSymbols2-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansSyriac-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSyriacEastern-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansSyriacWestern-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTagalog-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTagbanwa-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTaiLe-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTaiTham-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTaiViet-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTakri-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTamil-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTamilUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTamilSupplement-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTangsa-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTelugu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTeluguUI-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTest-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansThaana-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansThai-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansThaiLooped-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTifinagh-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAdrar-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAgrawImazighen-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAhaggar-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAir-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAPT-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghAzawagh-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghGhat-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghHawad-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghRhissaIxa-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghSIL-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansTifinaghTawellemmet-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansTirhuta-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansUgaritic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansVai-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansVithkuqi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSansWancho-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansWarangCiti-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansYi-Regular.ttf').readAsBytesSync().buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSansZanabazarSquare-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifAhom-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifArmenian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifBalinese-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifBengali-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifDevanagari-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifDivesAkuru-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifDogra-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifEthiopic-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifGeorgian-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifGrantha-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifGujarati-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifGurmukhi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifHebrew-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifKannada-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifKhitanSmallScript-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifKhmer-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifKhojki-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifLao-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifMakasar-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifMalayalam-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifMyanmar-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifNPHmong-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifOldUyghur-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifOriya-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoSerifOttomanSiyaq-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifSinhala-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifTamil-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifTangut-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifTelugu-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifTest-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifThai-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifTibetan-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifToto-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifVithkuqi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(File('assets/fonts/NotoSerifYezidi-Regular.ttf')
        .readAsBytesSync()
        .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoTraditionalNushu-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
    pw.Font.ttf(ByteData.view(
        File('assets/fonts/NotoZnamennyMusicalNotation-Regular.ttf')
            .readAsBytesSync()
            .buffer)),
  ];

  String _status = 'Ready';
  List<Printer> _printers = [];

  @override
  void initState() {
    super.initState();
    _getPrinters();
  }

  // Future<void> _loadFont() async {
  //   final fontData = await rootBundle.load("fonts/Roboto-Regular.ttf");
  //   _font = pw.Font.ttf(fontData);
  // }

  Future<void> _getPrinters() async {
    final printers = await Printing.listPrinters();
    setState(() {
      _printers = printers;
    });
  }

  Future<File?> _savePdf(pw.Document pdf) async {
    try {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Please select an output file:',
        fileName: 'label_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      if (outputFile == null) {
        // User canceled the picker
        return null;
      }

      final file = File(outputFile);
      await file.writeAsBytes(await pdf.save());
      return file;
    } catch (e) {
      print('Error saving PDF: $e');
      return null;
    }
  }

  Future<void> _printLabel(Printer printer) async {
    setState(() {
      _status = 'Preparing label...';
    });

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(
          60 * PdfPageFormat.mm,
          40 * PdfPageFormat.mm,
          marginAll: 2 * PdfPageFormat.mm,
        ),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'ഇംഗ്ലീഷ് 英语',
                    style: pw.TextStyle(
                      font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                      fontSize: 10,
                      fontFallback: fallbackFontList,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'अंग्रेज़ी સુરત',
                    style: pw.TextStyle(
                      font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                      fontSize: 10,
                      fontFallback: fallbackFontList,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                      DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now()),
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontFallback: fallbackFontList,
                        font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                      )),
                  pw.Text('Take Away',
                      style: pw.TextStyle(
                        fontFallback: fallbackFontList,
                        fontSize: 8,
                        font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                      )),
                ],
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Text('French Fries',
                  style: pw.TextStyle(
                      fontFallback: fallbackFontList,
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold)),
              pw.Text('Small',
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontFallback: fallbackFontList,
                    font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                  )),
              pw.Text('ketchup | Source',
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontFallback: fallbackFontList,
                    font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                  )),
              pw.Text('1 X Topping(+₹100)',
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontFallback: fallbackFontList,
                    font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                  )),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('₹300.00',
                    style: pw.TextStyle(
                        font: pw.Font.ttf(ByteData.view(bytes.buffer)),
                        fontSize: 10,
                        fontFallback: fallbackFontList,
                        fontWeight: pw.FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );

    setState(() {
      _status = 'Saving PDF...';
    });

    final file = await _savePdf(pdf);

    if (file != null) {
      setState(() {
        _status = 'PDF saved to: ${file.path}';
      });

      setState(() {
        _status = 'Sending print job...';
      });

      await Printing.directPrintPdf(
        format: const PdfPageFormat(
          60 * PdfPageFormat.mm,
          40 * PdfPageFormat.mm,
          marginAll: 2 * PdfPageFormat.mm,
        ),
        printer: printer,
        onLayout: (format) async {
          return pdf.save();
        },
      );

      setState(() {
        _status = 'Print job sent successfully!';
      });
    } else {
      setState(() {
        _status = 'PDF saving canceled or failed';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Select a printer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _printers.length,
                itemBuilder: (context, index) {
                  final printer = _printers[index];
                  return ListTile(
                    title: Text(printer.name),
                    subtitle: Text(printer.url),
                    onTap: () => _printLabel(printer),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text('Status: $_status'),
          ],
        ),
      ),
    );
  }
}

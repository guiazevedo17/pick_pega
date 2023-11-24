import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
import '../models/product.dart';
import '../models/restaurant.dart';

class QRCode extends StatefulWidget {
  const QRCode({super.key});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  String result = '';
  Restaurant? restaurant;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  Future<void> restaurante() async {
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantById/$result');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);
      //print("jsonBody: $jsonBody");
      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];

      restaurant = Restaurant(
        uid: jsonBody['uid'],
        name: jsonBody['name'],
        category: jsonBody['category'],
        address: Address(
            zip: jsonBody['address[zip]'],
            number: jsonBody['address[number]'],
            uf: jsonBody['address[uf]'],
            city: jsonBody['address[city]'],
            street: jsonBody['address[street]'],
            neighborhood: jsonBody['address[neighborhood]']),
        lat: jsonBody['lat'],
        lng: jsonBody['lng'],
        photo: jsonBody['photo'],
      );
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData.code!;
      });
      await restaurante();
      if(restaurant != null) {
        Navigator.of(context).pushNamed(
          '/restaurant_menu',
          arguments: restaurant,);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(

              child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(60), bottom: Radius.zero)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png',
                  width: 60,
                  height: 60,),
                  const Text('Escaneie o QR Code presente no restaurante', style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2) - 100, top: MediaQuery.of(context).size.height * 0.2),
              child: SvgPicture.asset('assets/icons/scan.svg', width: 200, height: 200,),
            ),),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: actionYellow,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: 8,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: white,
                  size: 20,
                ),
              ),
            ),
          ),
    ]
      ),
    );
  }
}

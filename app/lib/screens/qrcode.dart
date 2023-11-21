import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
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

  Future<void> restaurante(String result) async {
    print("Resukt: $result");
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantById/$result');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);

      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];
      print("Payload: $payload");
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // Future<Object?> getRestaurantById() async {
  //   final uri = Uri.parse(
  //       'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantById/$result');
  //
  //   final response = await http.get(uri);
  //
  //   if (response.statusCode == 200) {
  //     // Parse o JSON a partir do corpo da resposta
  //     final jsonBody = json.decode(response.body);
  //
  //     // Acesse o valor da chave 'payload' no JSON
  //     final payload = jsonBody['payload'];
  //     print(payload);
  //     // Agora, 'payload' é uma lista de elementos
  //     // List<Map<String, dynamic>> listOfRestaurants =
  //     // List<Map<String, dynamic>>.from(payload);
  //
  //     // restaurant = listOfRestaurants.map((restaurantMap) {
  //     //   return Restaurant(
  //     //     uid: restaurantMap['uid'],
  //     //     name: restaurantMap['name'],
  //     //     category: restaurantMap['category'],
  //     //     address: Address(
  //     //         zip: restaurantMap['address[zip]'],
  //     //         number: restaurantMap['address[number]'],
  //     //         uf: restaurantMap['address[uf]'],
  //     //         city: restaurantMap['address[city]'],
  //     //         street: restaurantMap['address[street]'],
  //     //         neighborhood: restaurantMap['address[neighborhood]']),
  //     //     lat: restaurantMap['lat'],
  //     //     lng: restaurantMap['lng'],
  //     //     photo: restaurantMap['photo'],
  //     //   );
  //     // }).toList();
  //
  //     return restaurant;
  //   } else {
  //     // Se a solicitação falhar, você pode lidar com o erro aqui.
  //     print('Request failed with status: ${response.statusCode}');
  //     return [];
  //   }
  // }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
        print("Resultado: $result");
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated)),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Scan result:  $result",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return Text('Pause: ${snapshot.data}');
                            },
                          )
                      )
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                            await restaurante(result);
                            setState(() {});
                          },
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return Text('Payload: ${snapshot.data}');
                            },
                          )
                      )
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

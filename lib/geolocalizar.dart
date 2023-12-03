import 'package:cam_geo/camara.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geolocalizador extends StatefulWidget {
  const Geolocalizador({super.key});

  @override
  State<Geolocalizador> createState() => _GeolocalizadorState();
}

class _GeolocalizadorState extends State<Geolocalizador> {
  Future<Position> determinePos() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentPos() async {
    Position position = await determinePos();
    print(position.latitude);
    print(position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 100, 0, 1)),
        title: const Text(
          'Geolocalización',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: const Color.fromRGBO(255, 100, 0, 1),
      ),
      drawer: Drawer(
        elevation: 10,
        width: 250,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 87,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 100, 0),
                ),
                padding: EdgeInsets.only(bottom: 25),
                child: Center(
                  child: Text(
                    'Menú',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.camera,
                color: Color.fromARGB(255, 255, 100, 0),
              ),
              title: const Text(
                'Cámara',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final route =
                    MaterialPageRoute(builder: (context) => const Camara());
                Navigator.push(context, route);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ElevatedButton(
            onPressed: () {
              getCurrentPos();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.amber.shade900),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.pin_drop),
                  Text(
                    '  Localizar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

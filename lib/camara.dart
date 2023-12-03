import 'package:cam_geo/geolocalizar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camara extends StatefulWidget {
  const Camara({super.key});

  @override
  State<Camara> createState() => _CamaraState();
}

class _CamaraState extends State<Camara> {
  Future<void> _optionsDialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Tomar foto'),
                  onTap: () {
                    _openCam();
                  },
                ),
                const Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                  child: const Text('Seleccionar de galería'),
                  onTap: () {
                    _openGal();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCam() {
    ImagePicker().pickImage(source: ImageSource.camera);
  }

  void _openGal() {
    ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 100, 0, 1)),
        title: const Text(
          'Cámara',
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
                Icons.pin_drop,
                color: Color.fromARGB(255, 255, 100, 0),
              ),
              title: const Text(
                'Geolocalización',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (context) => const Geolocalizador());
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
              _optionsDialogBox();
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.amber.shade900),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => const Color.fromARGB(255, 0, 0, 0))),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.camera),
                  Text(
                    '  Camera',
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

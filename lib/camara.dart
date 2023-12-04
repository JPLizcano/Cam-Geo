import 'dart:io';

import 'package:cam_geo/geolocalizar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class Camara extends StatefulWidget {
  const Camara({super.key});

  @override
  State<Camara> createState() => _CamaraState();
}

class _CamaraState extends State<Camara> {
  File? _img;
  var msg = "No ha seleccionado una imágen";

  Future<void> _opciones() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(100, 255, 255, 255),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _openCam(1);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.amber.shade900),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromARGB(170, 0, 0, 0))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        Text(
                          '  Tomar foto',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                ElevatedButton(
                  onPressed: () {
                    _openCam(2);
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.amber.shade900),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color.fromARGB(170, 0, 0, 0))),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.photo),
                        Text(
                          '  Seleccionar de la galería',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _openCam(op) async {
    var image;
    if (op == 1) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (image != null) {
        _img = File(image.path);
      } else {
        msg = "No ha seleccionado una imágen";
      }
    });
  }

  Future<void> _save() {
    var fnl;
    if (_img == null) {
      fnl = "Error al guardar la imágen!";
    } else {
      GallerySaver.saveImage(_img!.path);
      fnl = "Imgágen guardada con éxito...";
      setState(() {
        _img = null;
      });
    }
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(fnl),
        );
      },
    );
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _opciones();
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
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _save();
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
                          Icon(Icons.save_alt),
                          Text(
                            '  Guardar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _img == null
              ? Text(msg)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Image.file(_img!),
                ),
        ],
      ),
    );
  }
}

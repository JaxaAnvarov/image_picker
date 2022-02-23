import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? tanlanganRarm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                "Galeriyadan rasm olish",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: uploadImages,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: const Text(
                "Kameradan rasm olish",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: cameraImage,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyan.shade200,
                image: DecorationImage(
                  image: tanlanganRarm != null
                      ? FileImage(
                          File(tanlanganRarm!.path),
                        )
                      : FileImage(
                          File(''),
                        ),
                  fit: BoxFit.cover,
                ),
              ),
              height: 300.0,
              width: 300.0,
              // child: const Text("Rasm yo'q"),
            ),
            ElevatedButton(
              child: const Text("Send Data"),
              onPressed: () async {
                await Dio().post(
                  'http://localhost:3000/image',
                  data: {
                    'index ': '1',
                    'imageUrl': 'salom ${tanlanganRarm.toString()}'
                  },
                ).then((value) => value);
                debugPrint('Hello${tanlanganRarm.toString()}');

              },
            )
          ],
        ),
      ),
    );
  }

  Future uploadImages() async {
    try {
      XFile? rasm = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (rasm == null) return;
      setState(() {
        debugPrint("wewewewew $tanlanganRarm");
        tanlanganRarm = XFile(rasm.path);
        debugPrint("123456789 : ${rasm.path}");
      });
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  cameraImage() async {
    XFile? rasm = await ImagePicker().pickImage(source: ImageSource.camera);
    if (rasm == null) return;

    setState(() {
      tanlanganRarm = XFile(rasm.path);
      debugPrint("Tanlangan rasm pathsi => ${tanlanganRarm!.path}");
      debugPrint("Rasmning pathsi =>  ${rasm.path}");

      String newImage = tanlanganRarm!.path.replaceAll("/", '');
      debugPrint("new image ${newImage.toString()}");
      String newImages =
          newImage.replaceFirst('datauser0com.example.imagecache', '');
      debugPrint("images => $newImages");
    });
  }
}

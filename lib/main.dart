import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WahedIDE()));
}

class WahedIDE extends StatefulWidget {
  @override
  State<WahedIDE> createState() => _WahedIDEState();
}

class _WahedIDEState extends State<WahedIDE> {
  String openFile = "pubspec.yaml";
  String code = "";
  TextEditingController ctrl = TextEditingController();

  Map<String, String> allFiles = {
    "pubspec.yaml": "name: wahed_ide\ndescription: واحد عراقي IDE\npublish_to: 'none'\nversion: 1.0.0+1\n\nenvironment:\n sdk: '>=3.0.0 <4.0.0'\n\ndependencies:\n flutter:\n sdk: flutter\n\nflutter:\n uses-material-design: true",
    "main.dart": "import 'package:flutter/material.dart';\nvoid main(){ runApp(MaterialApp(home: Scaffold(body: Center(child: Text('واحد عراقي 1'))))); }",
    "main.yml": "name: Build Flutter APK\non: workflow_dispatch\njobs:\n build:\n runs-on: ubuntu-24.04\n steps:\n - uses: actions/checkout@v5\n - uses: actions/setup-java@v5\n - uses: subosito/flutter-action@v2\n - run: flutter build apk --release",
    "MainActivity.kt": "package com.iq.wahed_IDE\nimport io.flutter.embedding.android.FlutterActivity\nclass MainActivity: FlutterActivity() {}",
    "AndroidManifest.xml": "<manifest package=\"com.iq.wahed_IDE\">\n <application android:icon=\"@mipmap/ic_launcher\">\n <activity android:name=\".MainActivity\" />\n </application>\n</manifest>",
    "styles.xml": "<resources>\n <style name=\"NormalTheme\">\n <item name=\"android:windowBackground\">@drawable/launch_background</item>\n </style>\n</resources>",
    "build.gradle": "android { compileSdkVersion 34\n defaultConfig { applicationId \"com.iq.wahed_IDE\" } }",
    "gradle-wrapper.properties": "distributionUrl=https\\://services.gradle.org/distributions/gradle-8.4-all.zip",
    "settings.gradle": "include ':app'",
    "local.properties": "sdk.dir=/Android/sdk\nflutter.sdk=/flutter",
  };

  @override
  void initState() {
    super.initState();
    code = allFiles["pubspec.yaml"]!;
    ctrl.text = code;
  }

  void open(String name) {
    setState(() {
      openFile = name;
      code = allFiles[name]?? "// $name";
      ctrl.text = code;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010409),
      appBar: AppBar(
        backgroundColor: Color(0xFF010409),
        title: Text("wahed_IDE - $openFile", style: TextStyle(color: Colors.white, fontSize: 13)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF0D1117),
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF010409)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 40, height: 40, decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(8)), child: Center(child: Text("1", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
                  SizedBox(height: 10),
                  Text("wahed_IDE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("com.iq.wahed_IDE - كل الملفات موجودة", style: TextStyle(color: Colors.white38, fontSize: 10)),
                ],
              ),
            ),
            // نفس الشجرة الي بالفيديو
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text(".github", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true),
            Padding(padding: EdgeInsets.only(left: 30), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("workflows", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 60), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("main.yml", style: TextStyle(color: openFile=="main.yml"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("main.yml"))),

            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("android", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), dense: true),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("app", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 40), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("src / main / kotlin / com / iq / wahed_IDE", style: TextStyle(color: Colors.white, fontSize: 10)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 60), child: ListTile(leading: Icon(Icons.code, color: Color(0xFF2EA043), size: 18), title: Text("MainActivity.kt", style: TextStyle(color: openFile=="MainActivity.kt"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("MainActivity.kt"))),
            Padding(padding: EdgeInsets.only(left: 40), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("res", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 60), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFFD4AF37), size: 18), title: Text("drawable", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 80), child: ListTile(leading: Icon(Icons.image, color: Colors.white38, size: 18), title: Text("ic_launcher.png", style: TextStyle(color: Colors.white54, fontSize: 11)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 60), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFFD4AF37), size: 18), title: Text("values", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 80), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("styles.xml", style: TextStyle(color: openFile=="styles.xml"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("styles.xml"))),
            Padding(padding: EdgeInsets.only(left: 40), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("AndroidManifest.xml", style: TextStyle(color: openFile=="AndroidManifest.xml"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("AndroidManifest.xml"))),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("build.gradle", style: TextStyle(color: openFile=="build.gradle"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("build.gradle"))),

            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("gradle / wrapper", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradle-wrapper.jar", style: TextStyle(color: Colors.white54, fontSize: 11)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradle-wrapper.properties", style: TextStyle(color: openFile=="gradle-wrapper.properties"? Color(0xFFD4AF37): Colors.white70, fontSize: 11)), dense: true, onTap: ()=> open("gradle-wrapper.properties"))),
            ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradle.properties", style: TextStyle(color: Colors.white54, fontSize: 12)), dense: true),
            ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradlew", style: TextStyle(color: Colors.white54, fontSize: 12)), dense: true),
            ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradlew.bat", style: TextStyle(color: Colors.white54, fontSize: 12)), dense: true),
            ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("local.properties", style: TextStyle(color: openFile=="local.properties"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("local.properties")),
            ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("settings.gradle", style: TextStyle(color: openFile=="settings.gradle"? Color(0xFFD4AF37): Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("settings.gradle")),

            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder_open, color: Color(0xFFD4AF37), size: 18), title: Text("lib", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)), dense: true),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.code, color: Color(0xFF58A6FF), size: 18), title: Text("main.dart", style: TextStyle(color: openFile=="main.dart"? Color(0xFFD4AF37): Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)), dense: true, onTap: ()=> open("main.dart"))),
            ListTile(leading: Icon(Icons.description, color: Color(0xFFD4AF37), size: 18), title: Text("pubspec.yaml", style: TextStyle(color: openFile=="pubspec.yaml"? Color(0xFFD4AF37): Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), dense: true, onTap: ()=> open("pubspec.yaml")),

            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(12), child: Column(children: [
              Row(children: [Expanded(child: _btn("الذكاء الاصطناعي", Color(0xFF1F6FEB))), SizedBox(width: 8), Expanded(child: _btn("إعدادات المشروع", Color(0xFF21262D)))]),
              SizedBox(height: 8),
              Row(children: [Expanded(child: _btnAction("بناء APK", Color(0xFF238636))), SizedBox(width: 8), Expanded(child: _btnAction("تصدير ZIP", Color(0xFF21262D)))]),
              SizedBox(height: 8),
              _btnAction("كل المشاريع", Color(0xFF21262D)),
            ])),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 36,
            color: Color(0xFF161B22),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [
              Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(6)), child: Text(openFile, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
              SizedBox(width: 8),
              Text("كل الملفات موجودة", style: TextStyle(color: Color(0xFF2EA043), fontSize: 10)),
            ]),
          ),
          Expanded(
            child: TextField(
              controller: ctrl,
              maxLines: null,
              expands: true,
              style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "monospace"),
              decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12), filled: true, fillColor: Color(0xFF0D1117)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFD4AF37),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("بناء ${openFile} - BUILD SUCCESSFUL")));
        },
        label: Text("بناء APK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        icon: Icon(Icons.play_arrow, color: Colors.black),
      ),
    );
  }

  Widget _btn(String t, Color c) {
    return Container(height: 38, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8)), child: Center(child: Text(t, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))));
  }

  Widget _btnAction(String t, Color c) {
    return Container(height: 38, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFF30363D))), child: Center(child: Text(t, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))));
  }
}
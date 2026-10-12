import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: PrankScreen()));
}

class PrankScreen extends StatefulWidget {
  @override
  State<PrankScreen> createState() => _PrankScreenState();
}

class _PrankScreenState extends State<PrankScreen> {
  int step = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () { if(mounted) setState(()=> step=1); });
    Future.delayed(Duration(seconds: 3), () { if(mounted) setState(()=> step=2); });
  }
  @override
  Widget build(BuildContext context) {
    if(step==2){
      return Scaffold(
        backgroundColor: Color(0xFF0D1117),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("😂😂😂", style: TextStyle(fontSize: 60)),
              SizedBox(height: 16),
              Container(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: Color(0xFF2EA043), borderRadius: BorderRadius.circular(20)), child: Text("والله مقلب!", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold))),
              SizedBox(height: 16),
              Text("جهازك مأمن 100% ✅", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("التطبيق ما بيه اي فايروس", style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(height: 16),
              Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Color(0xFF161B22), borderRadius: BorderRadius.circular(12), border: Border.all(color: Color(0xFFD4AF37))), child: Text("واحد عراقي - يخوف بس ما يهكر 😎", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold))),
              SizedBox(height: 30),
              SizedBox(width: double.infinity, height: 54, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=> WahedIDE())); }, child: Text("ههههه ادخل للتطبيق", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)))),
            ]),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red, size: 80),
          SizedBox(height: 16),
          Text("تم تهكيرك!", style: TextStyle(color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          if(step==1)...[
            Text("جاري سحب الصور...", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontFamily: "monospace")),
            Text("جاري سحب جهات الاتصال...", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontFamily: "monospace")),
            Text("جاري رفع الملفات...", style: TextStyle(color: Colors.redAccent, fontSize: 12, fontFamily: "monospace")),
            SizedBox(height: 20),
            Container(width: 200, child: LinearProgressIndicator(color: Colors.red, backgroundColor: Colors.white10)),
            SizedBox(height: 8),
            Text("78% - لا تغلق التطبيق!", style: TextStyle(color: Colors.red, fontSize: 10)),
          ],
        ]),
      ),
    );
  }
}

class WahedIDE extends StatefulWidget {
  @override
  State<WahedIDE> createState()=> _WahedIDEState();
}

class _WahedIDEState extends State<WahedIDE> {
  String openFile = "pubspec.yaml";
  TextEditingController ctrl = TextEditingController();
  Map<String,String> files = {
    "pubspec.yaml": "name: wahed_ide\nversion: 1.0.0+1\ndependencies:\n flutter:\n sdk: flutter\nflutter:\n uses-material-design: true",
    "main.dart": "import 'package:flutter/material.dart';\nvoid main(){ runApp(MaterialApp(home: Scaffold(body: Center(child: Text('واحد عراقي IDE - 1'))))); }",
    "main.yml": "name: Build APK\non: workflow_dispatch\njobs:\n build:\n runs-on: ubuntu-latest\n steps:\n - uses: actions/checkout@v5\n - run: flutter build apk --release",
    "MainActivity.kt": "package com.iq.wahed_IDE\nimport io.flutter.embedding.android.FlutterActivity\nclass MainActivity: FlutterActivity() {}",
    "AndroidManifest.xml": "<manifest package=\"com.iq.wahed_IDE\">\n <application android:icon=\"@mipmap/ic_launcher\">\n <activity android:name=\".MainActivity\" />\n </application>\n</manifest>",
    "styles.xml": "<resources><style name=\"NormalTheme\"><item name=\"android:windowBackground\">@drawable/launch_background</item></style></resources>",
    "build.gradle": "android { compileSdkVersion 34\n defaultConfig { applicationId \"com.iq.wahed_IDE\" } }",
    "gradle-wrapper.properties": "distributionUrl=https://services.gradle.org/distributions/gradle-8.4-all.zip",
    "settings.gradle": "include ':app'",
    "local.properties": "sdk.dir=/Android/sdk",
  };

  @override
  void initState(){ super.initState(); ctrl.text = files["pubspec.yaml"]!; }

  void open(String name){
    setState((){ openFile=name; ctrl.text=files[name]??""; });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF010409),
      appBar: AppBar(backgroundColor: Color(0xFF010409), title: Text("wahed_IDE - $openFile", style: TextStyle(color: Colors.white, fontSize: 13)), iconTheme: IconThemeData(color: Colors.white)),
      drawer: Drawer(
        backgroundColor: Color(0xFF0D1117),
        width: 300,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(decoration: BoxDecoration(color: Color(0xFF010409)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(8)), child: Center(child: Text("1", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))), SizedBox(height: 10), Text("wahed_IDE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text("com.iq.wahed_IDE - كل الملفات", style: TextStyle(color: Color(0xFF2EA043), fontSize: 10))])),
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text(".github/workflows", style: TextStyle(color: Colors.white, fontSize: 12)), dense: true),
            Padding(padding: EdgeInsets.only(left: 30), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("main.yml", style: TextStyle(color: Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("main.yml"))),
            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("android/app/src/main/kotlin/com/iq/wahed_IDE", style: TextStyle(color: Colors.white, fontSize: 10)), dense: true),
            Padding(padding: EdgeInsets.only(left: 30), child: ListTile(leading: Icon(Icons.code, color: Color(0xFF2EA043), size: 18), title: Text("MainActivity.kt", style: TextStyle(color: Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("MainActivity.kt"))),
            Padding(padding: EdgeInsets.only(left: 30), child: ListTile(leading: Icon(Icons.folder, color: Color(0xFFD4AF37), size: 18), title: Text("res/drawable/values", style: TextStyle(color: Colors.white, fontSize: 11)), dense: true)),
            Padding(padding: EdgeInsets.only(left: 50), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("AndroidManifest.xml", style: TextStyle(color: Colors.white70, fontSize: 11)), dense: true, onTap: ()=> open("AndroidManifest.xml"))),
            Padding(padding: EdgeInsets.only(left: 50), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("styles.xml", style: TextStyle(color: Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("styles.xml"))),
            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder, color: Color(0xFF58A6FF), size: 18), title: Text("gradle/wrapper + gradle.properties + gradlew", style: TextStyle(color: Colors.white, fontSize: 10)), dense: true),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("gradle-wrapper.properties", style: TextStyle(color: Colors.white70, fontSize: 11)), dense: true, onTap: ()=> open("gradle-wrapper.properties"))),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text("build.gradle", style: TextStyle(color: Colors.white70, fontSize: 12)), dense: true, onTap: ()=> open("build.gradle"))),
            Divider(color: Color(0xFF21262D)),
            ListTile(leading: Icon(Icons.folder_open, color: Color(0xFFD4AF37), size: 18), title: Text("lib", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)), dense: true),
            Padding(padding: EdgeInsets.only(left: 20), child: ListTile(leading: Icon(Icons.code, color: Color(0xFF58A6FF), size: 18), title: Text("main.dart", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), dense: true, onTap: ()=> open("main.dart"))),
            ListTile(leading: Icon(Icons.description, color: Color(0xFFD4AF37), size: 18), title: Text("pubspec.yaml", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)), dense: true, onTap: ()=> open("pubspec.yaml")),
            SizedBox(height: 20),
          ],
        ),
      ),
      body: Column(children: [
        Container(height: 36, color: Color(0xFF161B22), padding: EdgeInsets.symmetric(horizontal: 12), child: Row(children: [Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Color(0xFFD4AF37), borderRadius: BorderRadius.circular(6)), child: Text(openFile, style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))), SizedBox(width: 8), Text("كل الملفات موجودة ✅", style: TextStyle(color: Color(0xFF2EA043), fontSize: 10))])),
        Expanded(child: TextField(controller: ctrl, maxLines: null, expands: true, style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: "monospace"), decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12), filled: true, fillColor: Color(0xFF0D1117)))),
      ]),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: Color(0xFFD4AF37), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Color(0xFF2EA043), content: Text("تم بناء $openFile - APK جاهز ⬇️ - سهم التنزيل"))); }, label: Text("بناء APK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), icon: Icon(Icons.play_arrow, color: Colors.black)),
    );
  }
}
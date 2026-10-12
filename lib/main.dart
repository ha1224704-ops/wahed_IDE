import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const WahedApp());
}

class WahedApp extends StatelessWidget {
  const WahedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String appName = "واحد عراقي";
  String appPackage = "iq.wahed.pro";
  String appVersion = "1.0.0";
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController(text: "// كود واحد عراقي - ببجي\nimport 'package:flutter/material.dart';\nvoid main(){runApp(MaterialApp(home: Scaffold(body: Center(child: Text('ببجي عراق 1247 لاعب')))));}");
  }

  void openBuild() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => BuildScreen(name: appName, pkg: appPackage, ver: appVersion)));
  }

  void openTemplates() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D1117),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("قوالب جاهزة - فول", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.menu_book, color: Color(0xFF2EA043)),
                title: const Text("القرآن الكريم", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    appName = "القرآن الكريم";
                    codeController.text = "// قرآن 114 سورة";
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.self_improvement, color: Color(0xFFD4AF37)),
                title: const Text("الاذكار", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    appName = "الاذكار";
                    codeController.text = "// اذكار";
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.fingerprint, color: Color(0xFF8B5CF6)),
                title: const Text("التسبيح", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    appName = "التسبيح";
                    codeController.text = "// تسبيح";
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.wifi_find, color: Color(0xFF00D9FF)),
                title: const Text("ماسح الشبكة", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    appName = "ماسح الشبكة";
                    codeController.text = "// شبكة";
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.sports_esports, color: Color(0xFFFF4444)),
                title: const Text("ببجي عراق", style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    appName = "ببجي عراق";
                    codeController.text = "// ببجي";
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        title: Text(appName, style: const TextStyle(color: Colors.white, fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: const Color(0xFF0D1117),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text("هيكل المشروع", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(color: Color(0xFF21262D)),
            const Expanded(
              child: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  ListTile(leading: Icon(Icons.folder, color: Color(0xFF3B82F6)), title: Text(".github", style: TextStyle(color: Colors.white))),
                  ListTile(leading: Icon(Icons.folder, color: Color(0xFF3B82F6)), title: Text("android", style: TextStyle(color: Colors.white))),
                  ListTile(leading: Icon(Icons.folder, color: Color(0xFF3B82F6)), title: Text("lib", style: TextStyle(color: Colors.white))),
                  ListTile(leading: Icon(Icons.description, color: Colors.white38), title: Text("pubspec.yaml", style: TextStyle(color: Colors.white70))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: btnDrawer("الذكاء الاصطناعي", const Color(0xFF1F6FEB), openTemplates)),
                      const SizedBox(width: 8),
                      Expanded(child: btnDrawer("اعدادات المشروع", const Color(0xFF21262D), () {})),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: btnAction("بناء APK", Icons.build, openBuild)),
                      const SizedBox(width: 8),
                      Expanded(child: btnAction("تصدير ZIP", Icons.archive, () {})),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(width: double.infinity, child: btnAction("كل المشاريع", Icons.folder_copy, () {})),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 34,
            color: const Color(0xFF161B22),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(6)),
                  child: const Text("main.dart", style: TextStyle(color: Colors.black, fontSize: 10)),
                ),
                const SizedBox(width: 8),
                const Text("يشتغل عالنت فقط", style: TextStyle(color: Colors.white38, fontSize: 9)),
                const Spacer(),
                const Icon(Icons.wifi, color: Color(0xFF2EA043), size: 14),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: codeController,
              maxLines: null,
              expands: true,
              style: const TextStyle(color: Color(0xFFC3E88D), fontSize: 12),
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFFD4AF37), onPressed: openBuild, child: const Icon(Icons.play_arrow, color: Colors.black)),
    );
  }

  Widget btnDrawer(String t, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(height: 44, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)), child: Center(child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 11)))),
    );
  }

  Widget btnAction(String t, IconData ic, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(12)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(ic, size: 14, color: Colors.white70), const SizedBox(width: 6), Text(t, style: const TextStyle(color: Colors.white, fontSize: 11))]),
      ),
    );
  }
}

class BuildScreen extends StatefulWidget {
  final String name;
  final String pkg;
  final String ver;
  const BuildScreen({super.key, required this.name, required this.pkg, required this.ver});
  @override
  State<BuildScreen> createState() => BuildScreenState();
}

class BuildScreenState extends State<BuildScreen> {
  List<String> logs = [];
  int current = 0;
  bool done = false;
  List<String> steps = ["Set up job", "Checkout", "Setup Gradle Cache", "Setup Java 17", "Setup Flutter", "Get dependencies", "Build APK", "Upload APK"];

  @override
  void initState() {
    super.initState();
    startBuild();
  }

  void startBuild() {
    Timer.periodic(const Duration(milliseconds: 600), (t) {
      if (current >= steps.length) {
        t.cancel();
        setState(() { done = true; });
        showCenter();
        return;
      }
      setState(() {
        logs.add("✓ " + steps[current]);
        current++;
      });
    });
  }

  void showCenter() {
    int p = 0;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setS) {
            Timer.periodic(const Duration(milliseconds: 20), (tt) {
              if (p >= 100) { tt.cancel(); return; }
              setS(() { p++; });
              if (p == 100) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  Navigator.pop(context);
                  showInstall();
                });
              }
            });
            return AlertDialog(
              backgroundColor: const Color(0xFF161B22),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 60, height: 60, decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(14)), child: const Center(child: Text("1", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)))),
                  const SizedBox(height: 12),
                  Text(widget.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(width: 100, height: 100, child: CircularProgressIndicator(value: p / 100, strokeWidth: 6, color: const Color(0xFFD4AF37))),
                      Text("$p%", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: p / 100, color: const Color(0xFFD4AF37)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showInstall() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF161B22),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF2EA043), size: 50),
              const SizedBox(height: 8),
              const Text("تم البناء 100%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(widget.name + ".apk جاهز", style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636)),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم تثبيت " + widget.name + " في جهازك")));
                  },
                  icon: const Icon(Icons.phone_android, color: Colors.white),
                  label: const Text("تثبيت في الجهاز", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () { Navigator.pop(context); showWeb(); }, icon: const Icon(Icons.language, size: 14), label: const Text("حمل من الموقع", style: TextStyle(fontSize: 10)))),
                  const SizedBox(width: 8),
                  Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(10)), child: IconButton(icon: const Icon(Icons.download, color: Colors.white), onPressed: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم حفظ " + widget.name + ".apk"))); })),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showWeb() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1117),
          title: const Text("تحميل من الموقع", style: TextStyle(color: Colors.white, fontSize: 14)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("اذا ما طلعت الواجهة روح للموقع", style: TextStyle(color: Colors.white70, fontSize: 11)),
              const SizedBox(height: 8),
              Text("wahed.iq/download/" + widget.name, style: const TextStyle(color: Color(0xFF58A6FF), fontSize: 12)),
              Text("wahed.iq/edit/" + widget.name, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
            ],
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("حفظ"))],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(backgroundColor: const Color(0xFF010409), title: Text(done? widget.name + ".apk جاهز" : "بناء GitHub", style: const TextStyle(color: Colors.white, fontSize: 12))),
      body: Column(
        children: [
          LinearProgressIndicator(value: current / steps.length, color: const Color(0xFFD4AF37)),
          Expanded(child: ListView.builder(padding: const EdgeInsets.all(12), itemCount: logs.length, itemBuilder: (context,i) => Text(logs[i], style: const TextStyle(color: Color(0xFF2EA043), fontSize: 11)))),
          if (done)
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFF161B22),
              child: Row(
                children: [
                  Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636)), onPressed: showCenter, icon: const Icon(Icons.looks_one), label: const Text("اظهار 1-100%", style: TextStyle(fontSize: 11)))),
                  const SizedBox(width: 8),
                  IconButton(style: IconButton.styleFrom(backgroundColor: const Color(0xFF21262D)), onPressed: showWeb, icon: const Icon(Icons.language, color: Color(0xFF58A6FF))),
                  IconButton(style: IconButton.styleFrom(backgroundColor: const Color(0xFF21262D)), onPressed: () {}, icon: const Icon(Icons.download, color: Colors.white)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
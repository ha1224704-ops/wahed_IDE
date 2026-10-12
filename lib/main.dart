import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const WahedApp());

class WahedApp extends StatelessWidget {
  const WahedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF0D1117)),
      home: const GithubLoginScreen(),
    );
  }
}

class GithubLoginScreen extends StatefulWidget {
  const GithubLoginScreen({super.key});
  @override
  State<GithubLoginScreen> createState() => _GithubLoginScreenState();
}

class _GithubLoginScreenState extends State<GithubLoginScreen> {
  final userCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 90, height: 90, decoration: BoxDecoration(color: const Color(0xFF161B22), borderRadius: BorderRadius.circular(22), border: Border.all(color: const Color(0xFF30363D))), child: const Icon(Icons.code, size: 50, color: Colors.white)),
            const SizedBox(height: 20),
            const Text('واحد عراقي', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const Text('سجل بـ GitHub', style: TextStyle(color: Color(0xFF8B949E))),
            const SizedBox(height: 30),
            TextField(controller: userCtrl, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'GitHub username', filled: true, fillColor: const Color(0xFF0D1117), enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF30363D)), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF1F6FEB)), borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { if (userCtrl.text.isNotEmpty) { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProjectsScreen(githubUser: userCtrl.text))); } }, child: const Text('دخول GitHub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          ]),
        ),
      ),
    );
  }
}

class ProjectsScreen extends StatefulWidget {
  final String githubUser;
  const ProjectsScreen({super.key, required this.githubUser});
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<Map<String, String>> projects = [];

  final Map<String, String> templates = {
    'القرآن الكريم': "import 'package:flutter/material.dart';\nvoid main()=>runApp(MaterialApp(home: Scaffold(backgroundColor: Color(0xFF0A1A0F), appBar: AppBar(title: Text('القرآن'), backgroundColor: Color(0xFF1A5D1A)), body: ListView(children: [ListTile(title: Text('الفاتحة', style: TextStyle(color: Colors.white)), subtitle: Text('بسم الله الرحمن الرحيم', style: TextStyle(color: Colors.white70))), ListTile(title: Text('البقرة', style: TextStyle(color: Colors.white)))]))));\n",
    'متجر': "import 'package:flutter/material.dart';\nvoid main()=>runApp(MaterialApp(home: Scaffold(appBar: AppBar(title: Text('متجر واحد')), body: Center(child: Text('منتجات')))));\n",
  };

  void newProject() {
    String code = templates['القرآن الكريم']!;
    String name = "مشروع_${projects.length + 1}";
    setState(() { projects.add({'name': name, 'code': code}); });
    Navigator.push(context, MaterialPageRoute(builder: (_) => EditorScreen(projectName: name, code: code, githubUser: widget.githubUser)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(backgroundColor: const Color(0xFF0D1117), title: const Text('Wahed IDE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('القوالب الجاهزة', style: TextStyle(color: Colors.white)))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1F6FEB)), onPressed: newProject, child: const Text('+ مشروع جديد', style: TextStyle(color: Colors.white)))),
        ])),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {}, child: const Text('استيراد مشروع من ZIP', style: TextStyle(color: Colors.white))))),
        const SizedBox(height: 20),
        Expanded(child: projects.isEmpty? Column(children: [const SizedBox(height: 80), Container(width: 100, height: 100, decoration: BoxDecoration(color: const Color(0xFF161B22), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.folder_open, color: Color(0xFF8B949E), size: 40)), const SizedBox(height: 12), const Text('لا توجد مشاريع بعد', style: TextStyle(color: Colors.white)), const Text('ابدأ بإنشاء مشروع Flutter الأول', style: TextStyle(color: Color(0xFF8B949E), fontSize: 12)), const SizedBox(height: 12), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1F6FEB)), onPressed: newProject, child: const Text('+ إنشاء مشروع'))]) : ListView.builder(itemCount: projects.length, itemBuilder: (c, i) => ListTile(title: Text(projects[i]['name']!, style: const TextStyle(color: Colors.white)), subtitle: Text(widget.githubUser, style: const TextStyle(color: Color(0xFF8B949E), fontSize: 10)), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EditorScreen(projectName: projects[i]['name']!, code: projects[i]['code']!, githubUser: widget.githubUser)))))),
      ]),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: const Color(0xFF0D1117), selectedItemColor: const Color(0xFF1F6FEB), unselectedItemColor: const Color(0xFF8B949E), type: BottomNavigationBarType.fixed, items: const [BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'مشاريع'), BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'المكتبة'), BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'AI'), BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'إعدادات')]),
    );
  }
}

class EditorScreen extends StatefulWidget {
  final String projectName;
  final String code;
  final String githubUser;
  const EditorScreen({super.key, required this.projectName, required this.code, required this.githubUser});
  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  late TextEditingController codeCtrl;
  List<String> logs = [];
  int errorCount = 0;
  int progressCounter = 0;
  Timer? timer;
  bool building = false;

  @override
  void initState() {
    super.initState();
    codeCtrl = TextEditingController(text: widget.code);
  }

  @override
  void dispose() {
    timer?.cancel();
    codeCtrl.dispose();
    super.dispose();
  }

  void startBuild() {
    setState(() { building = true; logs = []; errorCount = 0; progressCounter = 0; });
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 120), (t) {
      setState(() {
        progressCounter++;
        if (progressCounter > 100) {
          t.cancel();
          building = false;
          logs.add('✓ اكتمل التنزيل - ${widget.projectName}.apk جاهز');
          logs.add('✓ GitHub: ${widget.githubUser}/${widget.projectName}');
          return;
        }
      });
      if (progressCounter == 10) setState(() => logs.add('[$progressCounter%] > flutter pub get'));
      if (progressCounter == 25) setState(() => logs.add('[$progressCounter%] ✓ تحميل الحزم'));
      if (progressCounter == 40) setState(() => logs.add('[$progressCounter%] > فحص الكود main.dart'));
      if (progressCounter == 55) {
        if (codeCtrl.text.length < 30) {
          setState(() { logs.add('[$progressCounter%] ✗ خطأ في السطر 1: الكود قصير'); errorCount++; });
          timer?.cancel();
          setState(() => building = false);
        } else {
          setState(() => logs.add('[$progressCounter%] ✓ لا اخطاء'));
        }
      }
      if (progressCounter == 70) setState(() => logs.add('[$progressCounter%] > بناء APK...'));
      if (progressCounter == 85) setState(() => logs.add('[$progressCounter%] > توقيع الحزمة ${widget.projectName}'));
      if (progressCounter == 95) setState(() => logs.add('[$progressCounter%] > نسخ الى /storage/Download/'));
    });
  }

  void clearLogs() => setState(() { logs = []; errorCount = 0; progressCounter = 0; });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(backgroundColor: const Color(0xFF161B22), title: const Text('Klencod IDE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), centerTitle: true, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)), actions: [IconButton(onPressed: startBuild, icon: const Icon(Icons.play_arrow, color: Colors.white))]),
      body: Column(children: [
        Container(height: 28, color: const Color(0xFF21262D), child: const Center(child: Icon(Icons.arrow_drop_down, color: Color(0xFF8B949E)))),
        Container(height: 42, color: const Color(0xFF0D1117), padding: const EdgeInsets.symmetric(horizontal: 8), child: Row(children: [
          _logBtn('نسخ', () {}),
          const SizedBox(width: 6),
          _logBtn('مسح', clearLogs),
          const SizedBox(width: 6),
          _logBtn('GitHub', () {}),
          const SizedBox(width: 10),
          Text('أخطاء: $errorCount', style: const TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
          const Spacer(),
          Row(children: [
            Text(progressCounter > 0? '$progressCounter%' : '', style: const TextStyle(color: Color(0xFF1F6FEB), fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.settings, size: 16, color: Color(0xFF8B949E)),
            const SizedBox(width: 4),
            const Text('السجل', style: TextStyle(color: Color(0xFF8B949E), fontSize: 12)),
          ]),
        ])),
        Expanded(flex: 2, child: Container(color: const Color(0xFF0D1117), child: Column(children: [
          Container(height: 32, color: const Color(0xFF161B22), child: Row(children: [Container(margin: const EdgeInsets.all(4), padding: const EdgeInsets.symmetric(horizontal: 12), decoration: const BoxDecoration(color: Color(0xFF1F6FEB), borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6))), child: const Center(child: Text('main.dart', style: TextStyle(color: Colors.white, fontSize: 11))))])),
          Expanded(child: TextField(controller: codeCtrl, maxLines: null, expands: true, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12)))),
        ]))),
        Container(height: 220, decoration: const BoxDecoration(color: Color(0xFF010409), border: Border(top: BorderSide(color: Color(0xFF21262D)))), child: Column(children: [
          if (building) LinearProgressIndicator(value: progressCounter / 100, backgroundColor: const Color(0xFF21262D), color: const Color(0xFF1F6FEB)),
          Expanded(child: ListView.builder(padding: const EdgeInsets.all(8), itemCount: logs.length, itemBuilder: (c, i) => Padding(padding: const EdgeInsets.only(bottom: 3), child: Text(logs[i], style: TextStyle(color: logs[i].contains('✗')? const Color(0xFFF85149) : logs[i].contains('✓')? const Color(0xFF2EA043) : const Color(0xFF8B949E), fontSize: 11, fontFamily: 'monospace'))))),
          if (progressCounter > 0 && progressCounter < 100) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), color: const Color(0xFF161B22), child: Row(children: [const Icon(Icons.downloading, size: 14, color: Color(0xFF1F6FEB)), const SizedBox(width: 6), Text('جاري التنزيل... $progressCounter%', style: const TextStyle(color: Color(0xFF1F6FEB), fontSize: 11)), const Spacer(), Text('$progressCounter / 100', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))])),
        ])),
      ]),
    );
  }

  Widget _logBtn(String txt, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFF30363D))), child: Text(txt, style: const TextStyle(color: Color(0xFFC9D1D9), fontSize: 11))));
  }
}
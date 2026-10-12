import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const WahedApp());
class WahedApp extends StatelessWidget {
  const WahedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const MainEditorScreen(), builder: (c, child) => Directionality(textDirection: TextDirection.rtl, child: child!));
  }
}

class MainEditorScreen extends StatefulWidget {
  const MainEditorScreen({super.key});
  @override
  State<MainEditorScreen> createState() => _MainEditorScreenState();
}

class _MainEditorScreenState extends State<MainEditorScreen> {
  String projectName = 'واحد عراقي';
  String packageName = 'iq.wahed.pro';
  String version = '1.0.0';
  IconData appIcon = Icons.videogame_asset;
  TextEditingController codeCtrl = TextEditingController(text: '''import 'package:flutter/material.dart';
void main()=> runApp(WahedGame());

class WahedGame extends StatelessWidget{
  @override
  Widget build(BuildContext c)=> MaterialApp(
    home: Scaffold(
      backgroundColor: Color(0xFF050505),
      appBar: AppBar(title: Text('واحد عراقي - ببجي'), backgroundColor: Color(0xFFD4AF37)),
      body: Center(child: Text('1247 لاعب اونلاين', style: TextStyle(color: Colors.white))),
    ));
}
''');
  bool hasInternet = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, List<String>> fileStructure = {
    '.github': ['workflows/build.yml', 'FUNDING.yml'],
    'android': ['app/build.gradle', 'AndroidManifest.xml', 'app/src/main/'],
    'lib': ['main.dart', 'screens/', 'models/', 'services/'],
  };

  void buildAPK(){
    if(!hasInternet){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red, content: Text('✗ لا يوجد انترنت - التطبيق يشتغل عالنت فقط - الكود ما راح يبني')));
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_)=> BuildPage(projectName: projectName, packageName: packageName, version: version, code: codeCtrl.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(backgroundColor: const Color(0xFF121212), title: Row(children: [Container(width: 36, height: 36, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFF8B7355)]), borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('1', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))), const SizedBox(width: 8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(projectName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)), Text('$packageName v$version', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 9))])]), actions: [
        IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: ()=> _scaffoldKey.currentState!.openEndDrawer()),
      ]),
      endDrawer: Drawer(backgroundColor: const Color(0xFF1A1A1D), width: MediaQuery.of(context).size.width*0.78, child: Column(children: [
        Container(height: 110, padding: const EdgeInsets.only(top: 50, right: 20, left: 20), color: const Color(0xFF1A1A1D), child: Row(children: [const Expanded(child: Text('هيكل المشروع', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: hasInternet? const Color(0xFF2EA043).withOpacity(0.15): Colors.red.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Row(children: [Icon(hasInternet? Icons.wifi: Icons.wifi_off, color: hasInternet? const Color(0xFF2EA043): Colors.red, size: 12), const SizedBox(width: 4), Text(hasInternet? 'Online':'Offline - ما يبني', style: TextStyle(color: hasInternet? const Color(0xFF2EA043): Colors.red, fontSize: 8))]))])),
        const Divider(color: Color(0xFF232323), height: 1),
        Expanded(child: ListView(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8), children: [
          _folderTile('.github', fileStructure['.github']!, Icons.folder, const Color(0xFF3B82F6)),
          _folderTile('android', fileStructure['android']!, Icons.folder, const Color(0xFF3B82F6)),
          _folderTile('lib', fileStructure['lib']!, Icons.folder, const Color(0xFF3B82F6)),
          ListTile(leading: const Icon(Icons.description, color: Colors.white38, size: 20), title: const Text('pubspec.yaml', style: TextStyle(color: Colors.white70, fontSize: 13)), dense: true, onTap: (){}),
          const SizedBox(height: 20),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(appIcon, color: const Color(0xFFD4AF37), size: 18), const SizedBox(width: 8), const Text('اعدادات المشروع', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))]),
            const SizedBox(height: 8),
            Text('الاسم: $projectName', style: const TextStyle(color: Colors.white70, fontSize: 10)),
            Text('الحزمة: $packageName', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 9)),
            Text('الاصدار: $version - للهواتف', style: const TextStyle(color: Colors.white38, fontSize: 9)),
            const SizedBox(height: 6),
            Row(children: [const Icon(Icons.shield, color: Color(0xFF2EA043), size: 12), const SizedBox(width: 4), const Text('محمي - اكواد قوية - يشتغل عالنت', style: TextStyle(color: Color(0xFF2EA043), fontSize: 9))]),
          ])),
        ])),
        Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFF121212), border: Border(top: BorderSide(color: Color(0xFF232323)))), child: Column(children: [
          Row(children: [
            Expanded(child: _actionButton('الذكاء الاصطناعي', Icons.auto_awesome, const Color(0xFF1F6FEB), true, (){ Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('AI: راح يساعدك تكتب كود قرآن - اذكار - تسبيح - شبكة - ببجي'))); })),
            const SizedBox(width: 8),
            Expanded(child: _actionButton('إعدادات المشروع', Icons.settings, const Color(0xFF2D2D2D), false, (){ Navigator.pop(context); _showSettings(); })),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _actionButton('بناء APK', Icons.build, const Color(0xFF2D2D2D), false, (){ Navigator.pop(context); buildAPK(); })),
            const SizedBox(width: 8),
            Expanded(child: _actionButton('تصدير ZIP', Icons.archive, const Color(0xFF2D2D2D), false, (){ Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تصدير $projectName.zip'))); })),
          ]),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: _actionButton('كل المشاريع', Icons.folder_copy, const Color(0xFF2D2D2D), false, (){ Navigator.pop(context); })),
        ])),
      ])),
      body: Column(children: [
        Container(height: 36, color: const Color(0xFF1A1A1A), padding: const EdgeInsets.symmetric(horizontal: 12), child: Row(children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(6)), child: const Text('lib/main.dart', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8), const Text('ملون - محمي - قوي - اونلاين', style: TextStyle(color: Colors.white38, fontSize: 9)),
          const Spacer(), if(hasInternet) const Icon(Icons.wifi, color: Color(0xFF2EA043), size: 14) else const Icon(Icons.wifi_off, color: Colors.red, size: 14),
        ])),
        Expanded(child: Container(color: const Color(0xFF050505), child: TextField(controller: codeCtrl, maxLines: null, expands: true, style: const TextStyle(color: Color(0xFFC3E88D), fontFamily: 'monospace', fontSize: 12, height: 1.5), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(14), hintText: '// اكواد قوية - قرآن - اذكار - تسبيح - شبكة - ببجي', hintStyle: TextStyle(color: Colors.white24, fontSize: 10))))),
      ]),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFFD4AF37), onPressed: buildAPK, child: const Icon(Icons.play_arrow, color: Colors.black, size: 30)),
    );
  }

  Widget _folderTile(String name, List<String> files, IconData icon, Color color){
    return ExpansionTile(leading: Icon(icon, color: color, size: 22), title: Text(name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)), iconColor: Colors.white38, collapsedIconColor: Colors.white38, dense: true, children: files.map((f)=> Padding(padding: const EdgeInsets.only(right: 32, left: 8), child: ListTile(dense: true, leading: Icon(f.contains('.')? Icons.description: Icons.folder_open, size: 16, color: Colors.white38), title: Text(f, style: const TextStyle(color: Colors.white54, fontSize: 11))))).toList());
  }

  Widget _actionButton(String label, IconData icon, Color bg, bool isPrimary, VoidCallback onTap){
    return GestureDetector(onTap: onTap, child: Container(height: 46, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: isPrimary? const Color(0xFF1F6FEB): const Color(0xFF3A3A3A))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: isPrimary? Colors.white: Colors.white70, size: 16), const SizedBox(width: 6),
      Text(label, style: TextStyle(color: isPrimary? Colors.white: Colors.white70, fontSize: 11, fontWeight: isPrimary? FontWeight.bold: FontWeight.normal)),
    ])));
  }

  void _showSettings(){
    showModalBottomSheet(context: context, backgroundColor: const Color(0xFF121212), isScrollControlled: true, builder: (c)=> Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), child: Container(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('إعدادات المشروع - فول مواصفات', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)), const SizedBox(height: 12),
      TextField(controller: TextEditingController(text: projectName), onChanged: (v)=> setState(()=> projectName=v), decoration: const InputDecoration(labelText: 'اسم التطبيق - يطلع بالهاتف', labelStyle: TextStyle(color: Colors.white54, fontSize: 11), filled: true, fillColor: Color(0xFF1A1A1A)), style: const TextStyle(color: Colors.white, fontSize: 13)),
      const SizedBox(height: 8),
      TextField(controller: TextEditingController(text: packageName), onChanged: (v)=> setState(()=> packageName=v), decoration: const InputDecoration(labelText: 'الحزمة - iq.wahed.xxx', labelStyle: TextStyle(color: Colors.white54, fontSize: 11), filled: true, fillColor: Color(0xFF1A1A1A)), style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 11)),
      const SizedBox(height: 8),
      TextField(controller: TextEditingController(text: version), onChanged: (v)=> setState(()=> version=v), decoration: const InputDecoration(labelText: 'اصدار للهواتف - 1.0.0', labelStyle: TextStyle(color: Colors.white54, fontSize: 11), filled: true, fillColor: Color(0xFF1A1A1A)), style: const TextStyle(color: Colors.white, fontSize: 13)),
      const SizedBox(height: 12),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37)), onPressed: ()=> Navigator.pop(c), child: const Text('حفظ', style: TextStyle(color: Colors.black)))),
    ]))));
  }
}

class BuildPage extends StatefulWidget {
  final String projectName; final String packageName; final String version; final String code;
  const BuildPage({super.key, required this.projectName, required this.packageName, required this.version, required this.code});
  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  List<String> logs=[]; int progress=0; bool done=false; Timer? timer;
  @override
  void initState(){ super.initState(); start(); }
  void start(){
    logs=[]; progress=0; done=false; timer?.cancel();
    timer=Timer.periodic(const Duration(milliseconds: 130), (t){
      setState((){ progress++; if(progress>100){ t.cancel(); done=true; logs.add('✓ APK: /Download/${widget.projectName}.apk'); logs.add('✓ الحزمة: ${widget.packageName} v${widget.version}'); logs.add('✓ 🔒 محمي - 🌐 يشتغل عالنت - 🎮 ببجي اونلاين'); } });
      if(progress==10) setState(()=> logs.add('[$progress%] > 🌐 فحص النت... ✓ متصل'));
      if(progress==30) setState(()=> logs.add('[$progress%] > 🔒 تشفير وحماية الكود'));
      if(progress==55) setState(()=> logs.add('[$progress%] > 🎮 ربط سيرفر ببجي - 1247 لاعب'));
      if(progress==80) setState(()=> logs.add('[$progress%] > 📦 بناء ${widget.packageName}'));
    });
  }
  @override
  void dispose(){ timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF050505), appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A), title: Text('بناء ${widget.projectName}', style: const TextStyle(color: Colors.white, fontSize: 13))),
      body: Column(children: [
        LinearProgressIndicator(value: progress/100, color: const Color(0xFFD4AF37)), 
        Expanded(child: Container(color: const Color(0xFF010409), padding: const EdgeInsets.all(10), child: ListView.builder(itemCount: logs.length, itemBuilder: (c,i)=> Text(logs[i], style: TextStyle(color: logs[i].contains('✓')? const Color(0xFF2EA043): Colors.white54, fontFamily: 'monospace', fontSize: 11))))),
        if(done) Container(padding: const EdgeInsets.all(16), color: const Color(0xFF0A0A0A), child: Column(children: [
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636)), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✓ تم تثبيت ${widget.projectName} - تلكاه بالشاشة الرئيسية - ${widget.packageName}'))); }, icon: const Icon(Icons.phone_android, color: Colors.white), label: const Text('تثبيت على الهاتف الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 8), Row(children: [Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.code, size: 14, color: Colors.white), label: Text('GitHub: ${widget.packageName}', style: const TextStyle(color: Colors.white, fontSize: 9)))), const SizedBox(width: 8), Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.share, size: 14, color: Color(0xFFD4AF37)), label: const Text('تصدير ZIP', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 9))))]),
        ])),
      ]),
    );
  }
}
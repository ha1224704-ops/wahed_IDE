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
  TextEditingController codeCtrl = TextEditingController(text: "import 'package:flutter/material.dart';\nvoid main()=> runApp(MaterialApp(home: Scaffold(body: Center(child: Text('واحد عراقي')))));\n");
  String projectName='لعبة البصرة';
  String packageName='iq.wahed.basra';
  String version='1.0.0';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  void openBuildLog(){
    Navigator.push(context, MaterialPageRoute(builder: (_)=> GithubBuildScreen(projectName: projectName, packageName: packageName, version: version)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(backgroundColor: const Color(0xFF0D1117), title: const Text('واحد عراقي IDE', style: TextStyle(color: Colors.white, fontSize: 13)), actions: [IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: ()=> _key.currentState!.openEndDrawer())]),
      endDrawer: Drawer(backgroundColor: const Color(0xFF0D1117), width: MediaQuery.of(context).size.width*0.8, child: Column(children: [
        Container(padding: const EdgeInsets.only(top: 50, right: 16, left: 16, bottom: 16), child: const Align(alignment: Alignment.centerRight, child: Text('هيكل المشروع', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
        Expanded(child: ListView(children: [
          _folder('.github'), _folder('android'), _folder('lib'),
          const ListTile(leading: Icon(Icons.description, color: Colors.white38, size: 18), title: Text('pubspec.yaml', style: TextStyle(color: Colors.white70, fontSize: 12))),
        ])),
        Padding(padding: const EdgeInsets.all(12), child: Column(children: [
          Row(children: [Expanded(child: _btn('الذكاء الاصطناعي', true)), const SizedBox(width: 8), Expanded(child: _btn('إعدادات المشروع', false))]),
          const SizedBox(height: 8),
          Row(children: [Expanded(child: _btnAction('بناء APK', Icons.build, openBuildLog)), const SizedBox(width: 8), Expanded(child: _btnAction('تصدير ZIP', Icons.archive, (){}))]),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: _btnAction('كل المشاريع', Icons.folder_copy, (){})),
        ])),
      ])),
      body: TextField(controller: codeCtrl, maxLines: null, expands: true, style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 12), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(14))),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFFD4AF37), onPressed: openBuildLog, child: const Icon(Icons.play_arrow, color: Colors.black)),
    );
  }

  Widget _folder(String n)=> ExpansionTile(leading: const Icon(Icons.folder, color: Color(0xFF3B82F6), size: 20), title: Text(n, style: const TextStyle(color: Colors.white, fontSize: 12)), dense: true, children: [Padding(padding: const EdgeInsets.only(right: 40), child: Align(alignment: Alignment.centerRight, child: Text('ملفات $n', style: const TextStyle(color: Colors.white38, fontSize: 10))))]);
  Widget _btn(String t, bool primary)=> Container(height: 44, decoration: BoxDecoration(color: primary? const Color(0xFF1F6FEB): const Color(0xFF21262D), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF30363D))), child: Center(child: Text(t, style: TextStyle(color: primary? Colors.white: const Color(0xFFC9D1D9), fontSize: 11, fontWeight: FontWeight.bold))));
  Widget _btnAction(String t, IconData ic, VoidCallback onTap)=> GestureDetector(onTap: onTap, child: Container(height: 44, decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF30363D))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(ic, size: 14, color: Colors.white70), const SizedBox(width: 6), Text(t, style: const TextStyle(color: Colors.white, fontSize: 11))]))),
}

// شاشة بناء مثل الفيديو - GitHub Actions
class GithubBuildScreen extends StatefulWidget {
  final String projectName, packageName, version;
  const GithubBuildScreen({super.key, required this.projectName, required this.packageName, required this.version});
  @override
  State<GithubBuildScreen> createState() => _GithubBuildScreenState();
}

class _GithubBuildScreenState extends State<GithubBuildScreen> {
  List<Map<String,dynamic>> steps = [
    {'name': 'Set up job', 'time': '2s', 'status': 'done'},
    {'name': 'Checkout', 'time': '1s', 'status': 'done'},
    {'name': 'Setup Gradle Cache', 'time': '9s', 'status': 'pending'},
    {'name': 'Setup Java 17', 'time': '', 'status': 'pending'},
    {'name': 'Setup Flutter', 'time': '', 'status': 'pending'},
    {'name': 'Get dependencies', 'time': '', 'status': 'pending'},
    {'name': 'Build APK', 'time': '', 'status': 'pending'},
    {'name': 'Upload APK', 'time': '', 'status': 'pending'},
    {'name': 'Post Setup Java 17', 'time': '', 'status': 'pending'},
    {'name': 'Post Setup Gradle Cache', 'time': '', 'status': 'pending'},
    {'name': 'Post Checkout', 'time': '', 'status': 'pending'},
  ];
  int currentStep = 2;
  bool finished = false;
  Timer? timer;
  bool hasInternet = true;

  @override
  void initState(){
    super.initState();
    startBuild();
  }

  void startBuild(){
    if(!hasInternet){
      setState(()=> steps[2] = {'name': 'لا يوجد انترنت - ما يبني', 'time': '', 'status': 'error'});
      return;
    }
    timer = Timer.periodic(const Duration(milliseconds: 900), (t){
      if(currentStep >= steps.length){ t.cancel(); setState(()=> finished=true); return; }
      setState((){
        steps[currentStep]['status'] = 'running';
        Future.delayed(const Duration(milliseconds: 600), (){
          if(mounted){ setState((){
            steps[currentStep]['status']='done';
            steps[currentStep]['time']='${(currentStep*2+3)}s';
            currentStep++;
          }); }
        });
      });
    });
  }

  @override
  void dispose(){ timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(backgroundColor: const Color(0xFF010409), title: Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.copy, size: 12, color: Colors.white54), SizedBox(width: 4), Text('نسخ', style: TextStyle(color: Colors.white54, fontSize: 10))])), const SizedBox(width: 6),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(6)), child: const Text('مسح', style: TextStyle(color: Colors.white54, fontSize: 10))), const SizedBox(width: 6),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(6)), child: const Text('GitHub', style: TextStyle(color: Colors.white54, fontSize: 10))),
        const Spacer(),
        Text(finished? '${widget.projectName}.apk جاهز':'جاري البناء...', style: const TextStyle(color: Color(0xFF8B949E), fontSize: 10)),
        const SizedBox(width: 6),
        const Icon(Icons.settings, size: 14, color: Color(0xFF8B949E)),
      ])),
      body: Column(children: [
        Container(color: const Color(0xFF010409), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Row(children: [
          const Text('تسجيل البناء', style: TextStyle(color: Color(0xFF8B949E), fontSize: 10)),
          const Spacer(),
          Text('نسبة مئوية (${steps.where((s)=> s['status']=='done').length}/12)', style: const TextStyle(color: Color(0xFF8B949E), fontSize: 10)),
        ])),
        Expanded(child: ListView.builder(padding: const EdgeInsets.all(12), itemCount: steps.length, itemBuilder: (c,i){
          var s = steps[i];
          IconData icon; Color col;
          if(s['status']=='done'){ icon=Icons.check_circle; col=const Color(0xFF2EA043); }
          else if(s['status']=='running'){ icon=Icons.circle; col=const Color(0xFFD29922); }
          else if(s['status']=='error'){ icon=Icons.error; col=Colors.red; }
          else { icon=Icons.radio_button_unchecked; col=const Color(0xFF484F58); }
          return Container(margin: const EdgeInsets.only(bottom: 6), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), decoration: BoxDecoration(color: s['status']=='running'? const Color(0xFF1A1A1A): Colors.transparent, borderRadius: BorderRadius.circular(8)), child: Row(children: [
            Icon(icon, color: col, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text(s['name'], style: TextStyle(color: s['status']=='done'? Colors.white: s['status']=='running'? const Color(0xFFD29922): Colors.white38, fontSize: 12, fontFamily: 'monospace'))),
            if(s['time']!='') Text(s['time'], style: const TextStyle(color: Color(0xFF8B949E), fontSize: 10)),
          ]));
        })),
        if(finished) Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(color: Color(0xFF161B22), border: Border(top: BorderSide(color: Color(0xFF30363D)))), child: Column(children: [
          Row(children: [const Icon(Icons.check_circle, color: Color(0xFF2EA043)), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${widget.projectName}.apk', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)), Text('${widget.packageName} v${widget.version} - 18.4 MB - /Download/', style: const TextStyle(color: Colors.white38, fontSize: 9))]))]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: SizedBox(height: 48, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), onPressed: (){
              showModalBottomSheet(context: context, backgroundColor: const Color(0xFF161B22), builder: (c)=> Container(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))), const SizedBox(height: 16),
                Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.android, color: Colors.black)), const SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.projectName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('${widget.packageName}', style: const TextStyle(color: Color(0xFF8B949E), fontSize: 10))])]),
                const SizedBox(height: 16),
                ListTile(leading: const Icon(Icons.download, color: Colors.white), title: const Text('تنزيل APK', style: TextStyle(color: Colors.white)), subtitle: const Text('حفظ في التنزيلات', style: TextStyle(color: Colors.white38, fontSize: 10)), onTap: (){ Navigator.pop(c); ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF238636), content: Text('✓ تم تنزيل ${widget.projectName}.apk - تلكاه في /Download'))); }),
                ListTile(leading: const Icon(Icons.phone_android, color: Color(0xFF2EA043)), title: const Text('تثبيت على الهاتف', style: TextStyle(color: Colors.white)), subtitle: const Text('تثبيت مباشر', style: TextStyle(color: Colors.white38, fontSize: 10)), trailing: const Icon(Icons.arrow_downward, color: Color(0xFF2EA043)), onTap: (){ Navigator.pop(c); ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF2EA043), content: Text('✓ جاري تثبيت ${widget.projectName}... افتحه من الشاشة الرئيسية'))); }),
                ListTile(leading: const Icon(Icons.share, color: Color(0xFFD4AF37)), title: const Text('مشاركة', style: TextStyle(color: Colors.white)), onTap: (){ Navigator.pop(c); }),
              ]))),
            }, icon: const Icon(Icons.arrow_downward, color: Colors.white), label: const Text('تنزيل وتثبيت APK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))))),
            const SizedBox(width: 8),
            Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFF21262D), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF30363D))), child: IconButton(icon: const Icon(Icons.download, color: Colors.white), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('✓ تم حفظ ${widget.projectName}.apk في التنزيلات - تلكاه عن طريق السهم ⬇️'))); })),
          ]),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: Text('تلكاه على GitHub: github.com/wahed-dev/${widget.projectName} - وبالهاتف عن طريق السهم ⬇️', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 9))),
        ])),
      ]),
    );
  }
}
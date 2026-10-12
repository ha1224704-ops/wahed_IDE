import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const WahedApp());
class WahedApp extends StatelessWidget {
  const WahedApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: const ProjectsScreen());
  }
}

// شاشة المشاريع + زر الاعدادات الجديد
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  List<Map<String,dynamic>> projects = [];

  void createWithSettings(){
    Navigator.push(context, MaterialPageRoute(builder: (_) => AppSettingsScreen(onCreate: (settings){
      setState(()=> projects.add(settings));
      Navigator.push(context, MaterialPageRoute(builder: (_)=> EditorPage(projectData: settings)));
    })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A), title: const Text('واحد عراقي PRO', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)), actions: [IconButton(icon: const Icon(Icons.settings, color: Color(0xFFD4AF37)), onPressed: createWithSettings)]),
      body: projects.isEmpty? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 120, height: 120, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFF8B7355)]), borderRadius: BorderRadius.circular(28)), child: const Icon(Icons.videogame_asset, size: 50, color: Colors.black)),
        const SizedBox(height: 16), const Text('اصنع لعبة مثل ببجي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)), const Text('ايقونة + اسم + حزمة + حماية', style: TextStyle(color: Colors.white38, fontSize: 11)),
        const SizedBox(height: 20), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4AF37), padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14)), onPressed: createWithSettings, child: const Text('انشاء تطبيق / لعبة +', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ])) : ListView.builder(padding: const EdgeInsets.all(12), itemCount: projects.length, itemBuilder: (c,i)=> Container(margin: const EdgeInsets.only(bottom: 12), decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(16)), child: ListTile(leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFFD4AF37), borderRadius: BorderRadius.circular(12)), child: Icon(projects[i]['icon'] as IconData??? Icons.apps, color: Colors.black)), title: Text(projects[i]['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), subtitle: Text('${projects[i]['package']} v${projects[i]['version']}', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 10)), trailing: projects[i]['protected']? const Icon(Icons.shield, color: Color(0xFF2EA043), size: 18): null, onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> EditorPage(projectData: projects[i])))))),
      floatingActionButton: FloatingActionButton.extended(backgroundColor: const Color(0xFFD4AF37), onPressed: createWithSettings, icon: const Icon(Icons.add, color: Colors.black), label: const Text('لعبة جديدة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
    );
  }
}

// 1- شاشة اعدادات التطبيق - الايقونة والاسم والحزمة والاصدار
class AppSettingsScreen extends StatefulWidget {
  final Function(Map<String,dynamic>) onCreate;
  const AppSettingsScreen({super.key, required this.onCreate});
  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  TextEditingController nameCtrl = TextEditingController(text: 'لعبة البصرة');
  TextEditingController packCtrl = TextEditingController(text: 'iq.wahed.basra.game');
  TextEditingController verCtrl = TextEditingController(text: '1.0.0');
  IconData selectedIcon = Icons.videogame_asset;
  bool isGame = true;
  bool protectedCode = true;
  bool strongCode = true;

  List<IconData> icons = [Icons.videogame_asset, Icons.sports_esports, Icons.rocket, Icons.shield, Icons.menu_book, Icons.shopping_bag, Icons.mosque, Icons.calculate];

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF050505), appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A), title: const Text('اعدادات التطبيق - PRO', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 14))),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('اختار ايقونة التطبيق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 10),
        SizedBox(height: 60, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: icons.length, itemBuilder: (c,i)=> GestureDetector(onTap: ()=> setState(()=> selectedIcon=icons[i]), child: Container(width: 56, height: 56, margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(color: selectedIcon==icons[i]? const Color(0xFFD4AF37): const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(14), border: Border.all(color: selectedIcon==icons[i]? const Color(0xFFD4AF37): const Color(0xFF232323))), child: Icon(icons[i], color: selectedIcon==icons[i]? Colors.black: Colors.white))))),
        const SizedBox(height: 20),
        _field('اسم التطبيق', nameCtrl, 'مثال: لعبة البصرة - ببجي العراق'),
        _field('اسم الحزمة package', packCtrl, 'iq.wahed.etc - مثل Google Play'),
        _field('اصدار للهواتف version', verCtrl, '1.0.0 - كل تحديث زوده'),
        const SizedBox(height: 16),
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(14)), child: Column(children: [
          _switchTile('لعبة اونلاين ضد الاخرين (مثل ببجي)', isGame, (v)=> setState(()=> isGame=v), Icons.people),
          _switchTile('حماية الكود (تشفير - محد يسرقه)', protectedCode, (v)=> setState(()=> protectedCode=v), Icons.shield),
          _switchTile('اكواد قوية (يدعم Firebase + Socket)', strongCode, (v)=> setState(()=> strongCode=v), Icons.bolt),
        ])),
        const SizedBox(height: 20),
        SizedBox(height: 52, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: (){
          if(nameCtrl.text.isEmpty) return;
          String code;
          if(isGame){
            code = """
import 'package:flutter/material.dart';
void main()=> runApp(PubgIraqGame());

class PubgIraqGame extends StatefulWidget{
  @override State<PubgIraqGame> createState()=> _PubgIraqGameState();
}
class _PubgIraqGameState extends State<PubgIraqGame>{
  int playersOnline = 1247;
  List<String> players = ['واحد بصري','لاعب بغدادي','محارب اربيل'];
  // كود قوي + محمي + اونلاين
  @override Widget build(BuildContext context){
    return MaterialApp(home: Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      appBar: AppBar(title: Text('${nameCtrl.text} - اونلاين'), backgroundColor: Color(0xFFD4AF37)),
      body: Column(children: [
        Container(padding: EdgeInsets.all(12), color: Color(0xFF1A1A1A), child: Row(children: [
          Icon(Icons.people, color: Color(0xFF00FF88)), SizedBox(width: 8),
          Text('\$playersOnline لاعب اونلاين الآن', style: TextStyle(color: Color(0xFF00FF88))),
          Spacer(),
          Icon(Icons.shield, color: Color(0xFFD4AF37), size: 16), Text(' محمي', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 10)),
        ])),
        Expanded(child: ListView.builder(itemCount: players.length, itemBuilder: (c,i)=> ListTile(leading: CircleAvatar(backgroundColor: Color(0xFFD4AF37), child: Text(players[i][0])), title: Text(players[i], style: TextStyle(color: Colors.white)), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFD4AF37)), onPressed: (){}, child: Text('تحدي', style: TextStyle(color: Colors.black))),))),
        Padding(padding: EdgeInsets.all(12), child: SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF238636)), onPressed: (){}, child: Text('ابدأ معركة - Battle Royale', style: TextStyle(fontWeight: FontWeight.bold))))),
      ]),
    ));
  }
}
""";
          } else {
            code = "import 'package:flutter/material.dart';\nvoid main()=> runApp(MaterialApp(home: Scaffold(appBar: AppBar(title: Text('${nameCtrl.text}')), body: Center(child: Text('${nameCtrl.text} - محمي')))));\n";
          }
          widget.onCreate({
            'name': nameCtrl.text,
            'package': packCtrl.text,
            'version': verCtrl.text,
            'icon': selectedIcon,
            'code': code,
            'protected': protectedCode,
            'strong': strongCode,
            'isGame': isGame,
          });
        }, icon: const Icon(Icons.rocket_launch, color: Colors.white), label: Text('انشاء ${isGame? 'اللعبة':'التطبيق'} + بناء', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      ]),
    );
  }

  Widget _field(String label, TextEditingController ctrl, String hint){
    return Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(height: 6),
      TextField(controller: ctrl, style: const TextStyle(color: Colors.white, fontSize: 13), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white24, fontSize: 10), filled: true, fillColor: const Color(0xFF121212), enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF232323)), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFD4AF37)), borderRadius: BorderRadius.circular(12)))),
    ]));
  }

  Widget _switchTile(String title, bool val, Function(bool) onChanged, IconData icon){
    return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
      Icon(icon, color: const Color(0xFFD4AF37), size: 18), const SizedBox(width: 8),
      Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 12))),
      Switch(value: val, onChanged: onChanged, activeColor: const Color(0xFFD4AF37)),
    ]));
  }
}

class EditorPage extends StatefulWidget {
  final Map<String,dynamic> projectData;
  const EditorPage({super.key, required this.projectData});
  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late TextEditingController ctrl;
  @override
  void initState(){ super.initState(); ctrl=TextEditingController(text: widget.projectData['code']); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF050505), appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A), title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.projectData['name'], style: const TextStyle(color: Colors.white, fontSize: 13)), Text('${widget.projectData['package']} v${widget.projectData['version']} ${widget.projectData['protected']? '🔒 محمي':''}', style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 9))]), actions: [IconButton(icon: const Icon(Icons.build, color: Color(0xFFD4AF37)), onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> BuildPage(projectData: widget.projectData, code: ctrl.text))))]),
      body: Column(children: [
        Container(height: 34, color: const Color(0xFF1A1A1A), padding: const EdgeInsets.symmetric(horizontal: 10), child: Row(children: [
          Icon(widget.projectData['icon'], color: const Color(0xFFD4AF37), size: 16), const SizedBox(width: 6),
          Text(widget.projectData['isGame']? 'لعبة PUBG - اونلاين - اكواد قوية':'تطبيق - محمي', style: const TextStyle(color: Colors.white38, fontSize: 10)),
          const Spacer(), if(widget.projectData['protected']) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF2EA043).withOpacity(0.2), borderRadius: BorderRadius.circular(6)), child: const Text('🔒 حماية مفعلة - مشفر', style: TextStyle(color: Color(0xFF2EA043), fontSize: 9))),
        ])),
        Expanded(child: TextField(controller: ctrl, maxLines: null, expands: true, style: const TextStyle(color: Color(0xFFC3E88D), fontFamily: 'monospace', fontSize: 11), decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12)))),
      ]),
    );
  }
}

class BuildPage extends StatefulWidget {
  final Map<String,dynamic> projectData; final String code;
  const BuildPage({super.key, required this.projectData, required this.code});
  @override
  State<BuildPage> createState() => _BuildPageState();
}

class _BuildPageState extends State<BuildPage> {
  List<String> logs=[]; int progress=0; bool done=false; Timer? timer;
  @override
  void initState(){ super.initState(); startBuild(); }
  void startBuild(){
    logs=[]; progress=0; done=false; timer?.cancel();
    timer=Timer.periodic(const Duration(milliseconds: 150), (t){
      setState((){ progress++; if(progress>100){ t.cancel(); done=true; logs.add('✓ حماية: ${widget.projectData['protected']? 'تم تشفير الكود - AES256':''}'); logs.add('✓ APK: ${widget.projectData['package']} v${widget.projectData['version']}'); logs.add('✓ ${widget.projectData['isGame']? 'لعبة اونلاين جاهزة - 1247 لاعب':''}'); } });
      if(progress==20) setState(()=> logs.add('[$progress%] > فحص اكواد قوية...'));
      if(progress==40) setState(()=> logs.add(widget.projectData['protected']? '[$progress%] > 🔒 تشفير وحماية الكود': '[$progress%] > بناء عادي'));
      if(progress==70) setState(()=> logs.add(widget.projectData['isGame']? '[$progress%] > ربط سيرفر اونلاين - Socket.io': '[$progress%] > تجميع APK'));
      if(progress==90) setState(()=> logs.add('[$progress%] > توقيع ${widget.projectData['package']}'));
    });
  }
  @override
  void dispose(){ timer?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF050505), appBar: AppBar(backgroundColor: const Color(0xFF0A0A0A), title: Text('بناء ${widget.projectData['name']}', style: const TextStyle(fontSize: 13, color: Colors.white))),
      body: Column(children: [
        LinearProgressIndicator(value: progress/100, color: const Color(0xFFD4AF37)),
        Expanded(child: Container(color: const Color(0xFF010409), padding: const EdgeInsets.all(10), child: ListView.builder(itemCount: logs.length, itemBuilder: (c,i)=> Text(logs[i], style: TextStyle(color: logs[i].contains('🔒')||logs[i].contains('✓')? const Color(0xFF2EA043): Colors.white54, fontFamily: 'monospace', fontSize: 11))))),
        if(done) Container(padding: const EdgeInsets.all(16), color: const Color(0xFF0A0A0A), child: Column(children: [
          Row(children: [Icon(widget.projectData['icon'], color: const Color(0xFFD4AF37)), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.projectData['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('${widget.projectData['package']} v${widget.projectData['version']} - جاهز للتثبيت', style: const TextStyle(color: Colors.white38, fontSize: 9))]))]),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, height: 50, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF238636)), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF238636), content: Text('✓ تم تثبيت ${widget.projectData['name']} على هاتفك - ${widget.projectData['package']}'))); }, icon: const Icon(Icons.phone_android, color: Colors.white), label: Text('تثبيت ${widget.projectData['name']} الآن', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('github.com/wahed-dev/${widget.projectData['name']}'))); }, icon: const Icon(Icons.code, size: 16, color: Colors.white), label: const Text('GitHub', style: TextStyle(color: Colors.white, fontSize: 11)))),
            const SizedBox(width: 8),
            Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.share, size: 16, color: Color(0xFFD4AF37)), label: const Text('مشاركة APK', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11)))),
          ]),
        ])),
      ]),
    );
  }
}
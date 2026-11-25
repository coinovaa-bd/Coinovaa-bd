import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(CoinovaaApp());

class CoinovaaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF0F172A)),
      home: LauncherScreen(),
    );
  }
}

// --- LAUNCHER ---
class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('COINOVAA', style: TextStyle(color: Colors.amber, fontSize: 38, fontWeight: FontWeight.bold)),
            Text('Earn Real Rewards', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 40),
            SizedBox(width: double.infinity, height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserLogin())),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Text('Open User App', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(width: double.infinity, height: 55,
              child: OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AdminLogin())),
                child: Text('Admin Login', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- USER LOGIN ---
class UserLogin extends StatefulWidget {
  @override _UserLoginState createState() => _UserLoginState();
}
class _UserLoginState extends State<UserLogin> {
  final idC = TextEditingController();
  final pwC = TextEditingController();
  String err = '';
  void login() async {
    if (idC.text.trim().length < 4) { setState(() => err = 'ID 4 অক্ষরের বেশি দাও'); return; }
    if (pwC.text.trim().length < 4) { setState(() => err = 'Password 4 অক্ষরের বেশি দাও'); return; }
    final p = await SharedPreferences.getInstance();
    await p.setString('userId', idC.text.trim());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainHome(userId: idC.text.trim())));
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Login / Sign Up'), backgroundColor: Color(0xFF0F172A)),
      body: Padding(padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('নতুন ID বানাও বা Login করো', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          TextField(controller: idC, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'User ID', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder())),
          SizedBox(height: 12),
          TextField(controller: pwC, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder())),
          SizedBox(height: 12),
          if (err.isNotEmpty) Text(err, style: TextStyle(color: Colors.red)),
          SizedBox(height: 12),
          SizedBox(width: double.infinity, height: 50,
            child: ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('Login', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
          ),
        ]),
      ),
    );
  }
}

class AdminLogin extends StatefulWidget {
  @override _AdminLoginState createState() => _AdminLoginState();
}
class _AdminLoginState extends State<AdminLogin> {
  final idC = TextEditingController();
  final pwC = TextEditingController();
  String err = '';
  void login() {
    if (idC.text.trim() == 'riyaduri56' && pwC.text.trim() == 'riyaduri@56') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminPanel()));
    } else {
      setState(() => err = 'ভুল ID / Password!');
    }
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login'), backgroundColor: Color(0xFF0F172A)),
      body: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Admin Login', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(controller: idC, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Admin ID', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder())),
        SizedBox(height: 12),
        TextField(controller: pwC, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(color: Colors.white70), border: OutlineInputBorder())),
        SizedBox(height: 12),
        if (err.isNotEmpty) Text(err, style: TextStyle(color: Colors.red)),
        SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('Login as Admin', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
        SizedBox(height: 10),
        Text('Only for Admin', style: TextStyle(color: Colors.white54)),
      ])),
    );
  }
}

class AdminPanel extends StatefulWidget {
  @override _AdminPanelState createState() => _AdminPanelState();
}
class _AdminPanelState extends State<AdminPanel> {
  int totalCoins = 0;
  List<String> users = [];
  @override void initState() { super.initState(); _load(); }
  void _load() async {
    final p = await SharedPreferences.getInstance();
    Set<String> keys = p.getKeys();
    int total = 0;
    List<String> u = [];
    for (var k in keys) {
      if (k.startsWith('coins_')) {
        u.add(k.replaceAll('coins_', ''));
        total += p.getInt(k) ?? 0;
      }
    }
    setState(() { users = u; totalCoins = total; });
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel'), backgroundColor: Color(0xFF0F172A)),
      body: Padding(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text('Total Users'), Text('${users.length}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))]))),
          SizedBox(width: 10),
          Expanded(child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Column(children: [Text('Total Coins', style: TextStyle(color: Colors.white60)), Text('$totalCoins', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))]))),
        ]),
        SizedBox(height: 16),
        Text('All Users', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Expanded(child: users.isEmpty ? Center(child: Text('কোনো User এখনো Login করেনি', style: TextStyle(color: Colors.white60))) : ListView.builder(itemCount: users.length, itemBuilder: (c, i) {
          return FutureBuilder<int>(future: SharedPreferences.getInstance().then((p) => p.getInt('coins_${users[i]}') ?? 0), builder: (ctx, snap) {
            return Container(margin: EdgeInsets.only(bottom: 8), padding: EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Row(children: [CircleAvatar(backgroundColor: Colors.amber, child: Text(users[i][0].toUpperCase())), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(users[i], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('ID: ${users[i]}', style: TextStyle(color: Colors.white54))])), Text('${snap.data ?? 0} Coins', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))]));
          });
        })),
      ])),
    );
  }
}
// --- MAIN HOME WITH 4 TABS ---
class MainHome extends StatefulWidget {
  final String userId;
  MainHome({required this.userId});
  @override _MainHomeState createState() => _MainHomeState();
}
class _MainHomeState extends State<MainHome> {
  int _index = 0;
  int coins = 600;
  @override void initState() { super.initState(); _load(); }
  void _load() async {
    final p = await SharedPreferences.getInstance();
    setState(() => coins = p.getInt('coins_${widget.userId}') ?? 600);
  }
  void _addCoins(int v) async {
    final p = await SharedPreferences.getInstance();
    setState(() => coins += v);
    await p.setInt('coins_${widget.userId}', coins);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('+$v Coins Added!')));
  }

  @override Widget build(BuildContext context) {
    List<Widget> pages = [
      // HOME
      SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Hello, ${widget.userId}', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Welcome back!', style: TextStyle(color: Colors.white60)),
          ]),
          Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)), child: Row(children: [Icon(Icons.monetization_on, size: 18), SizedBox(width: 4), Text('$coins Coins', style: TextStyle(fontWeight: FontWeight.bold))])),
        ]),
        SizedBox(height: 16),
        Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.amber, Colors.orange]), borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Total Balance', style: TextStyle(color: Colors.black54)),
          Text('$coins Coins', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Text('= ${(coins / 100).toStringAsFixed(0)} BDT', style: TextStyle(fontSize: 16)),
          SizedBox(height: 12),
          ElevatedButton(onPressed: () => setState(() => _index = 1), style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: Text('Earn More', style: TextStyle(color: Colors.white))),
        ])),
        SizedBox(height: 16),
        Text('Quick Actions', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(children: [
          Expanded(child: _actionCard(Icons.play_circle, 'Watch Video', '+2 Coins', () => _addCoins(2))),
          SizedBox(width: 10),
          Expanded(child: _actionCard(Icons.people, 'Refer Friend', '+50 Coins', () => setState(() => _index = 2))),
        ]),
      ])),
      // TASKS
      ListView(padding: EdgeInsets.all(16), children: [
        Text('Tasks', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        _taskCard('Watch Video', 'Watch a short video', '+2 Coins', () => _addCoins(2)),
        _taskCard('Daily Check-in', 'Open app daily', '+10 Coins', () => _addCoins(10)),
        _taskCard('Visit Website', 'Visit sponsor site', '+5 Coins', () => _addCoins(5)),
        _taskCard('Share App', 'Share with friends', '+20 Coins', () => _addCoins(20)),
      ]),
      // REFER
      Padding(padding: EdgeInsets.all(16), child: Column(children: [
        SizedBox(height: 20),
        Icon(Icons.card_giftcard, size: 80, color: Colors.amber),
        SizedBox(height: 12),
        Text('Invite & Earn 50 Coins', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        SizedBox(height: 10),
        Text('Your Refer Code: ${widget.userId}', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 20),
        Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Text('https://coinovaa-bd.github.io/Coinovaa-bd/?ref=${widget.userId}', style: TextStyle(color: Colors.white))),
        SizedBox(height: 16),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () => _addCoins(50), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('Copy Link & Earn', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
      ])),
      // PROFILE
      Padding(padding: EdgeInsets.all(16), child: Column(children: [
        SizedBox(height: 20),
        CircleAvatar(radius: 40, backgroundColor: Colors.amber, child: Text(widget.userId[0].toUpperCase(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))),
        SizedBox(height: 12),
        Text(widget.userId, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text('$coins Coins  •  ID: ${widget.userId}', style: TextStyle(color: Colors.white60)),
        SizedBox(height: 20),
        ListTile(tileColor: Colors.white10, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), leading: Icon(Icons.wallet, color: Colors.amber), title: Text('Withdraw', style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16)),
        SizedBox(height: 10),
        ListTile(tileColor: Colors.white10, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), leading: Icon(Icons.history, color: Colors.amber), title: Text('History', style: TextStyle(color: Colors.white)), trailing: Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16)),
        SizedBox(height: 10),
        ListTile(tileColor: Colors.white10, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), leading: Icon(Icons.logout, color: Colors.red), title: Text('Logout', style: TextStyle(color: Colors.white)), onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserLogin()))),
      ])),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: Color(0xFF1E293B),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Refer'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _actionCard(IconData icon, String title, String sub, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(icon, color: Colors.amber, size: 32), SizedBox(height: 8), Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(sub, style: TextStyle(color: Colors.amber))])));
  }
  Widget _taskCard(String title, String desc, String reward, VoidCallback onTap) {
    return Container(margin: EdgeInsets.only(bottom: 10), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(color: Colors.white60))])), Text(reward, style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)), SizedBox(width: 10), ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: Text('Start', style: TextStyle(color: Colors.black)))]));
  }
}

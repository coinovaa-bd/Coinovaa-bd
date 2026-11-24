import 'package:flutter/material.dart';

void main() => runApp(const CoinovaaApp());

const gold = Color(0xFFE8B944);
const ink = Color(0xFF101010);

class CoinovaaApp extends StatelessWidget {
  const CoinovaaApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Coinovaa BD',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ink,
      colorScheme: ColorScheme.fromSeed(seedColor: gold, brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const StartPage(),
  );
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('COINOVAA BD', style: TextStyle(color: gold, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 8),
        const Text('WATCH • PLAY • EARN', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 32),
        SizedBox(width: double.infinity, child: FilledButton(
          style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: ink),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserHome())),
          child: const Text('Open User App'),
        )),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: OutlinedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginPage())),
          child: const Text('Admin Login'),
        )),
        const SizedBox(height: 18),
        const Text('Prototype build — real accounts and payments are not connected.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 12)),
      ]),
    )),
  );
}

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final id = TextEditingController();
  final password = TextEditingController();
  String error = '';
  bool obscure = true;

  void login() {
    // Demo-only gate. Replace with server-side authentication before deployment.
    final validId = id.text.trim() == 'riyad5052';
final validpass = password.text == 'riyad505252';
    if (validId && validpass) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminDashboard(adminId: id.text.trim())));
    } else {
      setState(() => error = 'সঠিক Admin ID এবং Password দিন।');
    }
  }

  @override
  void dispose() { id.dispose(); password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Admin Login')),
    body: ListView(padding: const EdgeInsets.all(22), children: [
      const SizedBox(height: 28),
      const Icon(Icons.admin_panel_settings, color: gold, size: 64),
      const SizedBox(height: 18),
      const Text('COINOVAA BD ADMIN', textAlign: TextAlign.center, style: TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 28),
      TextField(controller: id, decoration: const InputDecoration(labelText: 'Admin Login ID', border: OutlineInputBorder(), hintText: 'OwnerAdmin / Admin2')),
      const SizedBox(height: 14),
      TextField(controller: password, obscureText: obscure, decoration: InputDecoration(labelText: 'Password', border: const OutlineInputBorder(), suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => obscure = !obscure)))),
      const SizedBox(height: 16),
      FilledButton(onPressed: login, style: FilledButton.styleFrom(backgroundColor: gold, foregroundColor: ink), child: const Text('Login')),
      if (error.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 12), child: Text(error, style: const TextStyle(color: Colors.redAccent))),
      const SizedBox(height: 16),
      const Text('Demo only: এই স্ক্রিনে ID যাচাই হয়, কিন্তু প্রকৃত password/server authentication এখনো যুক্ত নয়।', style: TextStyle(color: Colors.white60, fontSize: 12)),
    ]),
  );
}

class AdminDashboard extends StatelessWidget {
  final String adminId;
  const AdminDashboard({super.key, required this.adminId});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Admin Dashboard'), actions: [IconButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), icon: const Icon(Icons.logout))]),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Text('Welcome, $adminId', style: const TextStyle(color: gold, fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Full Admin Access — prototype dashboard'),
      const SizedBox(height: 18),
      const _AdminTile(Icons.people, 'Manage Users', 'View, block and review user accounts'),
      const _AdminTile(Icons.toll, 'Coin Management', 'Review coin adjustments'),
      const _AdminTile(Icons.video_library, 'Video & Tasks', 'Manage earning content'),
      const _AdminTile(Icons.group_add, 'Referral Settings', 'Configure referral rules'),
      const _AdminTile(Icons.payments, 'Withdraw Requests', 'Review bKash, Nagad and Rocket requests'),
      const _AdminTile(Icons.receipt_long, 'Transactions', 'Review transaction records'),
      const _AdminTile(Icons.settings, 'App Settings', 'Manage minimum withdrawal: ৳200'),
      const SizedBox(height: 14),
      const Text('These controls are visual placeholders. No user data, coins, withdrawals or payments are changed until a secure backend is connected.', style: TextStyle(color: Colors.white60)),
    ]),
  );
}

class _AdminTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  const _AdminTile(this.icon, this.title, this.subtitle);
  @override
  Widget build(BuildContext context) => Card(
    color: const Color(0xFF202020),
    child: ListTile(leading: Icon(icon, color: gold), title: Text(title), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right)),
  );
}

class UserHome extends StatelessWidget {
  const UserHome({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('COINOVAA BD')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: const Color(0xFF29210E), borderRadius: BorderRadius.circular(18), border: Border.all(color: gold)), child: const Column(children: [
        Text('YOUR BALANCE', style: TextStyle(color: gold)),
        SizedBox(height: 8),
        Text('0 Coins', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        Text('Demo balance only', style: TextStyle(color: Colors.white60)),
      ])),
      const SizedBox(height: 18),
      const _AdminTile(Icons.play_circle, 'Watch & Earn', 'Video rewards setup pending'),
      const _AdminTile(Icons.people, 'Refer & Earn', 'Referral setup pending'),
      const _AdminTile(Icons.task, 'Daily Tasks', 'Sponsor tasks setup pending'),
      const _AdminTile(Icons.sports_esports, 'Play Games', 'Game rewards setup pending'),
      const _AdminTile(Icons.account_balance_wallet, 'Withdraw', 'bKash • Nagad • Rocket | Minimum ৳200'),
    ]),
  );
}
